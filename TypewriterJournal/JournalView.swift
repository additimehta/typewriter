import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \JournalEntry.createdAt, order: .reverse) private var entries: [JournalEntry]
    @State private var draft = ""
    @State private var soundEnabled = true
    @State private var now = Date()

    private let ink = Color(red: 0.24, green: 0.22, blue: 0.20)
    private let paper = Color(red: 0.98, green: 0.96, blue: 0.91)
    private var visibleEntries: [JournalEntry] {
        entries.filter { $0.isKept || $0.expiresAt > now }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("Let it out.")
                        .font(.system(size: 31, weight: .medium, design: .serif))

                    ZStack(alignment: .topLeading) {
                        if draft.isEmpty {
                            Text("Start typing...")
                                .foregroundStyle(ink.opacity(0.45))
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $draft)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 230)
                            .opacity(draft.isEmpty ? 0.65 : 1)
                            .onChange(of: draft) { old, new in
                                if soundEnabled && new.count > old.count { TypingSound.shared.play() }
                            }
                    }
                    .font(.system(size: 18, design: .monospaced))

                    Button("Put it down") { save() }
                        .buttonStyle(.borderedProminent)
                        .tint(ink)
                        .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                    if !visibleEntries.isEmpty {
                        Divider()
                        Text("Your pages")
                            .font(.system(size: 23, design: .serif))
                        ForEach(visibleEntries) { entry in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(entry.text)
                                    .font(.system(size: 16, design: .monospaced))
                                Text(entry.isKept ? "Kept" : "Disappears \(entry.expiresAt.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                HStack {
                                    if !entry.isKept {
                                        Button("Keep this one") { entry.isKept = true }
                                    }
                                    Spacer()
                                    Button("Delete", role: .destructive) { context.delete(entry) }
                                }
                                .font(.subheadline)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white.opacity(0.65), in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding(24)
            }
            .foregroundStyle(ink)
            .background(paper.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        soundEnabled.toggle()
                    } label: {
                        Image(systemName: soundEnabled ? "speaker.wave.2" : "speaker.slash")
                    }
                    .accessibilityLabel(soundEnabled ? "Turn typing sound off" : "Turn typing sound on")
                }
            }
            .onAppear(perform: removeExpired)
            .onReceive(Timer.publish(every: 30, on: .main, in: .common).autoconnect()) { _ in
                removeExpired()
            }
        }
    }

    private func save() {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        context.insert(JournalEntry(text: text))
        draft = ""
    }

    private func removeExpired() {
        now = .now
        for entry in entries where entry.isExpired {
            context.delete(entry)
        }
    }
}
