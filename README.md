# Typewriter Journal

A small, private SwiftUI journal. Write a thought, leave it for 24 hours, or choose **Keep this one**. Entries are stored on the device using SwiftData. The writing screen uses a monospaced font and has an optional soft key sound.

## Open on a Mac

1. Install [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`).
2. In this folder, run `xcodegen generate`.
3. Open `TypewriterJournal.xcodeproj` in Xcode and run on an iOS 17+ simulator.

The app checks for expired entries when opened and while it is running. It does not run a background deletion task; expired entries will be removed the next time the app opens. There is no account or cloud sync in this starter.
