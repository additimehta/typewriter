import AVFoundation

final class TypingSound {
    static let shared = TypingSound()
    private var player: AVAudioPlayer?

    private init() {
        guard let url = Bundle.main.url(forResource: "key", withExtension: "wav") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.volume = 0.18
        player?.prepareToPlay()
    }

    func play() {
        player?.currentTime = 0
        player?.play()
    }
}
