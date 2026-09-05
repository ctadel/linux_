# Rectangle

`config.json` is the complete configuration exported from Rectangle's
Preferences UI. It includes the user defaults and shortcut assignments without
machine-specific window state.

To apply the tracked shortcuts:

```sh
plutil -replace allowAnyShortcut -bool true "$HOME/Library/Preferences/com.knollsoft.Rectangle.plist"
```

Import or restore it through Rectangle's Preferences UI.
