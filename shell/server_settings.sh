export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init --path)"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

function mediaready(){
    deactivate_all_envs
    cd ~/ttn/imaging_service
    pyenv activate imaging_service
    alias run='python main.py'
  }

alias adb="~/usr/platform-tools/adb"

function pwc(){
    if [[ -z "$1" ]];then
        deactivate_all_envs
        cd ~/ttn/pwc-python-transformation
        pyenv activate pwc-transformation
        #alias run='pwckit >/dev/null 2>&1 &; python run.py'
        alias run='python run.py'
        return

    elif [[ "$1" == "features" ]]; then
        features pwc

    else
        echo "Invalid arguement '$1'"

    fi
  }

function recon(){
    if [[ -z "$1" ]];then
        deactivate_all_envs
        cd ~/ttn/customs-recon-mapper
        conda activate recon-mapper
        alias run='python src/com/ttn/recon/main.py'
        return
    fi

    if [[ "$1" == "send" ]]; then
        if [[ -n "$2" ]]; then
            ~/ttn/libs/sender.py $2
        else
            ~/ttn/libs/sender.py
        fi

    elif [[ "$1" == "purge" ]]; then
        ~/ttn/libs/sender.py purge

    elif [[ "$1" == "count" ]]; then
        ~/ttn/libs/sender.py count

    elif [[ "$1" == "features" ]]; then
        features recon

    elif [[ "$1" == "gen" ]]; then
        ~/ttn/libs/generate_n_records_recon.py ${*:2}

    else
        echo "Invalid arguement '$1'"
    fi
}

# docker instance for minio
# docker run -d --name minio -v minio_storage:/data minio/minio -p 9000:9000 -p 9001:9001 server /data --console-address ":9001"

# docker instance for mongo
# docker run -d --name mongo -v mongo_data:/data/db -p 27017:27017 mongo

# docker instance for rabbitmq
# docker run -d --name rabbitmq -v rabbitmq_data:/var/lib/rabbitmq -p 15672:15672 -p 5672:5672 -e RABBITMQ_DEFAULT_USER=prajwal -e RABBITMQ_DEFAULT_PASS=valhala rabbitmq:management

pyenv activate global

function vpn(){
  echo -n $FORTI_KEY | copy
  /opt/forticlient/gui/FortiClient-linux-x64/FortiClient&> /dev/null
  echo -n $PRITUNL_KEY | copy
  pritunl-client-electron list&> /dev/null
}


repository_map["pwc-python-transformation"]="pwc_python_transformation"
repository_map["pwc"]="pwc_python_transformation"
repository_map["mediaready"]="imaging_service"
repository_map["mr"]="imaging_service"
repository_map["recon-mapper"]="recon_mapper"
repository_map["recon"]="recon_mapper"

FB_pwc_python_transformation=$(cat << EOF

#######################################################
            pwc-python-transformation
#######################################################

PWCGSTUAT-8758        - Power Insights

PWCGSTUAT-11442       - Icegate Register 1 (icegate sanctioned scrolls)
PWCGSTUAT-11443       - Icegate Register 2 (icegate pending scrolls)
PWCGSTUAT-12751       - Bank Register
PWCGSTUAT-11441       - Custom Sales Register
PWCGSTUAT-16321       - Commercial Invoice

PWCGSTUAT-13115       - Container Sheet Handler

PWCGSTUAT-16589       - Inward Register (asahi)

PWCGSTUAT-14185       - Addd field 'Under Protest'

EOF
)

FB_recon_mapper=$(cat << EOF

#######################################################
                        recon
#######################################################

PWCGSTUAT-13649       - Reconciliation for Custom Sales Register against Shipping Bill Data

EOF
)


export SONAR_SCANNER_HOME=/opt/sonar-scanner-5.0.1.3006-linux
export PATH=$PATH:/opt/sonar-scanner-5.0.1.3006-linux/bin

function airpwc(){
    if [[ -z "$1" ]];then
        deactivate_all_envs
        cd ~/ttn/projects/air-pwc
        pyenv activate airflow
        export AIRFLOW_HOME=~/ttn/projects/air-pwc
    else
        echo "Invalid arguement '$1'"
    fi
  }

function weather(){
    if [[ -z "$1" ]];then
        deactivate_all_envs
        cd ~/ttn/projects/weather-pipeline
        pyenv activate airflow
        export AIRFLOW_HOME=~/ttn/projects/weather-pipeline
    else
        echo "Invalid arguement '$1'"
    fi
  }
