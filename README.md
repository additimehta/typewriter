# Typewriter Journal

A native macOS desktop journal built with SwiftUI (macOS 14+). Write a thought, leave it for 24 hours, or choose **Keep this one**. Entries are stored on the device using SwiftData. The writing screen uses a monospaced font and has an optional soft key sound.

## Run the desktop app

1. Install [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`).
2. In this folder, run `xcodegen generate`.
3. Open `TypewriterJournal.xcodeproj` in Xcode and select **My Mac**, and press **Command-R** to run.

Use **Command-S** to save an entry. The sound toggle remembers your preference.

If you generated the previous iOS project, run `xcodegen generate` again after pulling this update.

The app checks for expired entries when opened, when brought to the foreground, and every 30 seconds while running. It does not run a background deletion task; expired entries will be removed the next time the app opens. There is no account or cloud sync in this starter.


