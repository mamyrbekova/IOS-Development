//
//  ViewController.swift
//  Amina_MusicPlayer
//
//  Created by Амина Мамырбекова on 05.11.2025.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    struct Track {
        let title: String
        let artist: String
        let coverImageName: String
        let audioFileName: String
    }

    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    
    private var audioPlayer: AVAudioPlayer?
    private var tracks: [Track] = []
    private var currentIndex: Int = 0 {
        didSet { updateUIForCurrentTrack() }
    }
    private var isPlaying: Bool = false {
        didSet { updatePlayPauseButtonAppearance() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        loadTracks()
        setupButtons()
        updateUIForCurrentTrack()
    }


    private func configureAppearance() {
        view.backgroundColor = UIColor.systemBackground
        trackTitleLabel.numberOfLines = 2
        trackTitleLabel.textAlignment = .center
        trackTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2).withWeight(.semibold)

        albumCoverImageView.contentMode = .scaleAspectFit
        albumCoverImageView.clipsToBounds = true
        albumCoverImageView.layer.cornerRadius = 12

    }

    private func loadTracks() {
        // Replace these with your actual filenames and asset names
        tracks = [
            Track(title: "Be With You", artist: "Akon", coverImageName: "akon", audioFileName: "Be With You.mp3"),
            Track(title: "Bleeding Love", artist: "Leona Lewis", coverImageName: "lewis", audioFileName: "Bleeding Love.mp3"),
            Track(title: "Just A Dream", artist: "Nelly", coverImageName: "nelly", audioFileName: "Just A Dream.mp3"),
            Track(title: "Want To Want Me", artist: "Jason Derulo", coverImageName: "jason", audioFileName: "Want To Want Me.mp3"),
            Track(title: "Without You", artist: "David Guetta", coverImageName: "david", audioFileName: "Without You.mp3")
        ]


        if tracks.isEmpty {

            tracks = [Track(title: "No tracks", artist: "", coverImageName: "", audioFileName: "")]
        }
    }

    private func setupButtons() {
        let buttons = [previousButton, playPauseButton, nextButton]

        for button in buttons {
            var config = UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            button?.configuration = config
            button?.tintColor = .label
        }

        previousButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        updatePlayPauseButtonAppearance()
    }

    
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        togglePlayPause()
    }
    
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        guard !tracks.isEmpty else { return }
        currentIndex = (currentIndex - 1 + tracks.count) % tracks.count
        stopAndPrepareToPlayIfNeeded(autoplay: isPlaying)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard !tracks.isEmpty else { return }
        currentIndex = (currentIndex + 1) % tracks.count
        stopAndPrepareToPlayIfNeeded(autoplay: isPlaying)
    }
    
    private func togglePlayPause() {
        if isPlaying {
            pausePlayback()
        } else {
            startPlayback()
        }
    }

    private func startPlayback() {
        if audioPlayer == nil {
            prepareAudioPlayerForCurrentTrack()
        }
        audioPlayer?.play()
        isPlaying = true
    }

    private func pausePlayback() {
        audioPlayer?.pause()
        isPlaying = false
    }

    private func stopPlayback() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
    }

    private func stopAndPrepareToPlayIfNeeded(autoplay: Bool) {
        stopPlayback()
        prepareAudioPlayerForCurrentTrack()
        if autoplay {
            audioPlayer?.play()
            isPlaying = true
        }
    }

    private func prepareAudioPlayerForCurrentTrack() {
        guard tracks.indices.contains(currentIndex) else {
            audioPlayer = nil
            return
        }

        let track = tracks[currentIndex]
        guard !track.audioFileName.isEmpty else {
            audioPlayer = nil
            return
        }

        let components = track.audioFileName.split(separator: ".")
        guard components.count == 2 else {
            audioPlayer = nil
            return
        }

        let resourceName = String(components[0])
        let ext = String(components[1])
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: ext) else {
            print("Audio file not found in bundle: \(track.audioFileName)")
            audioPlayer = nil
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
        } catch {
            print("Failed to initialize AVAudioPlayer: \(error)")
            audioPlayer = nil
        }
    }

    private func updateUIForCurrentTrack() {
        guard tracks.indices.contains(currentIndex) else {
            trackTitleLabel.text = "No Track"
            artistLabel.text = ""
            albumCoverImageView.image = nil
            return
        }

        let track = tracks[currentIndex]


        trackTitleLabel.text = track.title

        artistLabel.text = track.artist

        if !track.coverImageName.isEmpty, let img = UIImage(named: track.coverImageName) {
            albumCoverImageView.image = img
        } else {
            albumCoverImageView.image = UIImage(systemName: "music.note")
        }

        updatePlayPauseButtonAppearance()
    }


    private func updatePlayPauseButtonAppearance() {
        var config = playPauseButton.configuration ?? .plain()
        config.image = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        playPauseButton.configuration = config
    }
}


extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentIndex = (currentIndex + 1) % max(1, tracks.count)
        stopAndPrepareToPlayIfNeeded(autoplay: true)
    }
}

private extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
        return UIFont(descriptor: descriptor, size: pointSize)
    }

}
    


