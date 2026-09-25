import SwiftUI
import SwiftData

@main
struct TypewriterJournalApp: App {
    var body: some Scene {
        WindowGroup("Typewriter") {
            JournalView()
                .frame(minWidth: 560, minHeight: 480)
                .preferredColorScheme(.light)
        }
        .defaultSize(width: 820, height: 720)
        .modelContainer(for: JournalEntry.self)
    }
}
