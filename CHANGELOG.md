# Changelog

All notable changes to the **GameTurbo-Plus** project will be documented in this file.

## [v4.1] - 2025-11-23
### Added
* **Auto-Mode Loop:** New AI-driven background monitor that detects active games and re-applies boost automatically.
* **Thermal Bypass:** Added experimental support for reducing thermal throttling (Debug flag).
* **Extended Game List:** Added support for Genshin Impact, Mobile Legends, and COD Mobile detection.
* **Interactive Menu:** Complete UI overhaul with colored output and progress bars.

### Optimized
* **CPU Governor:** refined tuning for `schedutil` rate limits to decrease latency.
* **Network Stack:** Updated TCP buffer sizes for modern 5G/WiFi 6 connections.
* **Safety Checks:** Improved `safe_write` function to prevent crashes on unrooted devices.

### Fixed
* Fixed an issue where the script would fail if `/sys/class/kgsl` did not exist on non-Snapdragon devices.
* Resolved permission errors when writing to log files.