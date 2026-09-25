import SwiftUI
import SwiftData

@main
struct TypewriterJournalApp: App {
    var body: some Scene {
        WindowGroup {
            JournalView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}
