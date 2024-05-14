import os
import json
import time
import shlex
import argparse
import subprocess
from os import path
from threading import Thread
from collections import deque
from dataclasses import dataclass


# To support Python 3.8 and earlier versions
SCRIPT_DIR = path.dirname(path.realpath(__file__))

@dataclass
class Schema:
    """
        This dataclass is to help parse and hold the configuration file
    """

    name:str
    local_path:path = None
    remote_path:path = '~'
    exec:str = None
    launch_file:path = None
    files:dict = None

    _synced:int = 0
    _forced:int = False

    def initialize(self):
        if self.local_path:
            self.local_path = path.join(SCRIPT_DIR,
                                    self.local_path)
        else:
            self.local_path = SCRIPT_DIR

        self.remote_path = path.expanduser(self.remote_path)

        assert path.isdir(self.local_path), \
            f"Invalid local path for {self.name}"

        if self.files:
            _absolute_file_paths = {}
            for source, destination in self.files.items():
                assert path.exists(path.join(self.local_path, source)), \
                    f"File not found : {path.join(self.local_path, source)}"
                assert destination, "Must specify a remote path"

                _absolute_file_paths[path.join(self.local_path, source)] = path.join(
                        self.remote_path, destination)

            self.files = _absolute_file_paths

        else:
            self.files = {}
            assert self.local_path, \
                "Must define local_path folder if files are not specified."

            for root, _, files in os.walk(self.local_path):
                for file in files:

                    if file.endswith('.desktop'):
                        continue

                    _absolute_file_path = path.join(root, file)
                    _relative_path = path.relpath(_absolute_file_path, start=self.local_path)

                    self.files[_absolute_file_path] = \
                            path.join(self.remote_path, _relative_path)


        if self.launch_file:
            _relative_path = os.path.relpath(path.join(self.local_path, self.launch_file))
            assert path.exists(_relative_path), \
                    f"Missing launch file: {_relative_path}"

            self.launch_file = _relative_path


    def __repr__(self):
        return f"Schema<{self.name.replace(' ','-')}>"

    def __str__(self):
        _string = f'\n> {self.name}'
        _string += f'\nLocal path: {self.local_path}'
        _string += f'\nRemote path: {self.remote_path}'
        _string += f'\nExecute: {self.exec}'
        _string += f'\nLaunch File: {self.launch_file}'
        _string += f'\nFile Symlinks:\n'

        for source, destination in self.files.items():
            _string += f'  {source} -> {destination}\n'

        return _string + '\n'


    @classmethod
    def get_from_json_object(cls, data):
        data = json.loads(data)
        schema = Schema(**data)
        schema.initialize()
        return schema

def setup_arguments():
    """
        Use this function to add/edit sys arguments
    """

    parser = argparse.ArgumentParser(
            prog='ctadel.Sync',
            description='Sync your dot files with this fancy program.',
            epilog='prajwaldev.com.np',
         )

    parser.add_argument('--force', action='store_true',
            help='Overwrite currently existing configurations', default=False
        )

    parser.add_argument('-i', '--interactive', action='store_true',
            help='Choose what config to sync at run time', default=False
        )

    parser.add_argument('--log', nargs='?', const='application.log',
            help='Log the events of the program to a file'
        )

    return parser.parse_args()


def setup_logging(args):
    """
        Using this makes the program looks a little less printy everywhere.
        Instead of using python's logger module, this seemed more clean.
    """

    if not args.log:
        return

    os.chdir(SCRIPT_DIR)
    log_file = path.abspath(args.log)
    try:
        os.makedirs(path.dirname(log_file), exist_ok=True)

        global deque
        import sys
        from datetime import datetime

        class deque(deque):
            def append(self, line) -> None:
                with open(log_file, 'a+') as logger:
                    logger.write(line+'\n')
                return super().append(line)

        with open(log_file, 'a+') as logger:
            user_login = f'{os.getlogin()}@{os.uname()[1]}'
            sys_args = ' '.join(sys.argv)
            header = f'\n\n[{user_login}] {datetime.now()}\n{sys_args}\n'+'-'*100 + '\n'
            logger.write(header)

    except Exception as e:
        print(e)
        exit(1)


def load_configuration():
    config = path.join(SCRIPT_DIR, 'conf.json')
    with open(config) as conf:
        data = json.load(conf)

    for module in data.keys():
        data[module] = Schema(module, **data[module])
        data[module].initialize()

    return data


class DisplayManager:

    def __init__(self, modules, args) -> None:
        self.modules = modules
        self.args = args
        self.syncing = True
        self.description = deque(maxlen=10)

    @staticmethod
    def status_icon(module):

        action_count = len(module.files)
        if module.exec:
            action_count += 1
        if module.launch_file:
            action_count += 1

        if module._synced == 0:
            return '⚫'
        elif module._synced == action_count:
            return '🟢'
        elif module._synced in range(1, action_count):
            return '⭕'
        return '🔴'


    def display_title(self):
        print('------|| ctadel\'s configurations ||------ \n')

    def diplay_sync_status(self):
        for module in self.modules.values():
            print(' ', self.status_icon(module), f' {module.name}', end='')
            print('  (Overwritten)' if module._forced else '')
            # from random import choice
            # print(self.status_icon[choice([-1,0,1])], f' {module.name}')
        print()

    def display_description(self):
        for line in self.description:
            print(line)

    def display(self, loop=True):
        try:
            while self.syncing:
                os.system('clear')
                self.display_title()
                self.diplay_sync_status()
                self.display_description()
                time.sleep(0.1)

                if not loop:
                    break

        except KeyboardInterrupt:
            print("Exiting...")
            return


class Synchronize:

    def __init__(self, modules, args) -> None:
        self.modules = modules
        self.args = args
        self.console = DisplayManager(modules, args)


    def create_symlink(self, module, source, destination):
        try:
            os.makedirs(path.dirname(destination), exist_ok=True)

            if path.exists(destination) or path.islink(destination):
                if not self.args.force:
                    raise FileExistsError()
                os.remove(destination)
                module._forced = True

            os.symlink(source, destination)
            self.console.description.append(f'✔ {source} -> {destination}')
            return True

        except PermissionError:
            self.console.description.append(f'✘ Access Error: {destination}')
            return False
        except FileExistsError:
            self.console.description.append(f'✘ File already exists: {destination}')
            return False
        except Exception as e:
            self.console.description.append(f'✘ {source} -> {destination}')
            self.console.description.append(str(e))
            return False
        finally:
            # it just looks cool if texts are moving around
            time.sleep(0.05)


    def sync(self):

        YES = ['a', 'y', 'all', 'yes', 'yeah', 'yep']
        CHOOSE = ['f', 'c', 'choose', 'some']

        def display_with_input(module, *args, **kwargs):
            self.console.display(loop=False)
            print(f"\n --> [{module}]")
            return input(*args, **kwargs)

        if not self.args.interactive:
            printer = Thread(target=self.console.display)
            printer.start()

        for module in self.modules.values():

            sync_launch_file = True
            sync_exec = True

            if self.args.interactive:
                sync_module = display_with_input(module.name,
                     "Sync this module? [A/Y - All | F/C - Choose files | * - No]: ")
                if sync_module.lower() not in YES+CHOOSE:
                    module._synced = -1
                    continue

            for source, destination in module.files.items():
                if self.args.interactive:
                    if sync_module.lower() in CHOOSE:
                        sync_this_file = display_with_input(module.name, destination + '? [Y/N]: ')
                        if sync_this_file.lower() not in YES:
                            continue
                response = self.create_symlink(module, source, destination)
                if response:
                    module._synced += 1

            if self.args.interactive and \
                    module.launch_file and sync_module.lower() in CHOOSE:
                sync_launch_file = display_with_input(module.name, "Add launch file? [Y/N]: ")
                sync_launch_file = sync_launch_file.lower() in YES

            if module.launch_file and sync_launch_file:
                launch_file_dir = path.expanduser('~/.local/share/applications/')
                os.makedirs(launch_file_dir, exist_ok=True)
                response = self.create_symlink(module,
                        path.join(module.local_path, path.basename(module.launch_file)), \
                        path.join(launch_file_dir, path.basename(module.launch_file)))
                if response:
                    module._synced += 1

            if self.args.interactive and \
                    module.exec and sync_module.lower() in CHOOSE:
                sync_exec = display_with_input(module.name, "Execute exec script? [Y/N]: ")
                sync_exec = sync_exec.lower() in YES

            if module.exec and sync_exec:
                try:
                    _command = shlex.split(module.exec)

                    stdout, stderr = subprocess.Popen(_command, stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE, start_new_session=True
                                ).communicate()
                    output = stdout.decode() + stderr.decode()
                    self.console.description.append(
                            f'✔ Output for "{module.exec}" in {module.name}:\n{output.strip()}')
                    module._synced += 1

                except Exception as e:
                    self.console.description.append(
                            f'✘ Exception while executing "{module.exec}" for {module.name}\n{e}')

            if module.files and not module._synced:
                module._synced = -1

        self.console.display(loop=False)
        self.console.syncing = False


if __name__ == "__main__":
    args = setup_arguments()
    setup_logging(args)
    modules = load_configuration()
    sync = Synchronize(modules, args)
    sync.sync()

    if args.log:
        print(f"\nLogs: {path.abspath(args.log)}")
