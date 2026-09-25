import Foundation
import SwiftData

@Model
final class JournalEntry {
    var text: String
    var createdAt: Date
    var isKept: Bool

    init(text: String, createdAt: Date = .now, isKept: Bool = false) {
        self.text = text
        self.createdAt = createdAt
        self.isKept = isKept
    }

    var expiresAt: Date { createdAt.addingTimeInterval(24 * 60 * 60) }
    var isExpired: Bool { !isKept && expiresAt <= .now }
}
