# Aptum Dashboard full implementation

Important cleanup before upload:
- Delete old `Sources/ContentView.swift`
- Delete old `Sources/RideSensorManager.swift`
- Delete old project files

Features:
- Aptum bike image embedded directly in Swift with transparent background cleanup
- App icon asset included
- DUNEN FFE0/FFE1 BLE scan/connect/read/write pipeline
- Dashboard / Info / Tuning / Diagnostics / Settings
- Tuning unlock warning
- Read-current-settings first flow
- Toggles are disabled until settings are loaded
- No toggle defaults to 0 on connect
- Confirmation popup before enable/disable
- Backup JSON to Files before writing
- Only changed settings are written
- Backend/internal parameter names included
