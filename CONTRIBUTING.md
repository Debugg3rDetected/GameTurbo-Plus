# Contributing to GameTurbo-Plus

First off, thank you for considering contributing to GameTurbo-Plus! We welcome help from the community to make Android gaming smoother for everyone.

## How to Contribute

### Reporting Bugs
If you find a bug or the script crashes on your specific device model:
1.  Check the log file generated at `/tmp/GameTurbo-Plus.log`.
2.  Open an issue on GitHub describing the error and your device model/Android version.

### Suggesting Enhancements
* Have a new Kernel tweak?
* Know a better way to handle the LMK (Low Memory Killer)?
* Open a Pull Request (PR) with your changes.

### Pull Request Guidelines
1.  **Bash Best Practices:** Ensure your code is clean. Run your changes through `shellcheck` before submitting.
2.  **Safety First:** Use the provided `safe_write` and `cmd_safe` functions. Do not hard-code paths that might break on different Android versions.
3.  **Root Checks:** If adding a feature that requires Root, ensure there is a fallback or a check to prevent errors on non-rooted devices.

## Development Environment
* Development is primarily done directly on Android via Termux or via ADB.
* Test your changes on at least one rooted and one non-rooted environment if possible.

Thank you for your support!