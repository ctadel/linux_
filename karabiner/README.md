# Karabiner shortcuts

`karabiner.json` is the tracked source for the Karabiner profile configuration, and `prajwal_shortcuts.json` is the tracked source for the Linux-style complex modifications.

The `Prajwal Command Layout` profile's simple modifications use this physical
layout:

- Fn -> Command
- Control -> Fn
- Option -> Control
- Command -> Option

That makes the physical Fn key the macOS Command key, so Fn+C/V/N and
Fn+click use native macOS behavior. The physical Option key becomes the
Linux-style Control key, while the physical Command key becomes Option.
Complex rules translate special shortcuts and terminal Command keys as needed.

## Install

From the repository root:

```sh
./karabiner/setup.sh
```

The script links the shortcut source into Karabiner's assets directory, builds the live main config from both tracked JSON files, and resets `Guest` to an empty profile.

- `Prajwal Command Layout`: the new modifier remaps and tracked Linux-style rules.
- `Prajwal Legacy`: the previous Fn-as-Control modifier layout.
- `Guest`: standard macOS behavior.

Switch profiles from Karabiner-Elements or its menu bar icon.

## App switching and arrows

Fn+Tab and Fn+Shift+Tab use macOS's native app switcher, including reverse
cycling. Physical Command+Tab and Command+Shift+Tab become Control+Tab and
Control+Shift+Tab for cycling tabs. Command+` remains the native same-app
window switcher. External Alt+Tab continues to use the app switcher, while
external Windows+Tab and Windows+Shift+Tab continue to cycle same-application
windows.

Ctrl+Left/Right use Option+Arrow for word navigation. Ctrl+Backspace/Delete use Option+Delete for word deletion. Super+Left/Right uses Control+Arrow for workspace navigation.

In GUI applications, Ctrl+D opens bookmarks, Ctrl+P opens print, Ctrl+J opens downloads, and Ctrl+Shift+M opens Chrome's profile menu.

In VS Code, Ctrl+R maps to Redo (Command+Shift+Z), while Ctrl+Shift+P opens
the Command Palette.

Chrome also maps Ctrl+Shift+T/W to tab history, Ctrl+H to history, Ctrl+K/E to
the address bar, Ctrl+Shift+B to the bookmarks bar, Ctrl+Shift+J/I to developer
tools, Ctrl+Shift+Backspace to clear browsing data, and Ctrl+Plus/Minus/0 to
zoom controls.

In terminals, Fn+C/Z/D/H and common readline keys are translated back to
Control signals and editing commands. Fn+V pastes, and Fn+Shift+C/V provide
terminal copy and paste.

Moving the pointer dismissing the native macOS app switcher is controlled by macOS itself and cannot be changed by a Karabiner complex modification. The same-application Super+Tab path does not use that app switcher.
