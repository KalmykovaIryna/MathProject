//
//  SoundPlayer.swift
//  MathProject
//
//  Created by Iryna Rarova on 13.01.2023.
//

import UIKit
import AVFoundation


class SoundPlayer {
    static let shared: SoundPlayer = SoundPlayer()
    
    private init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private var audioPlayer: AVAudioPlayer?
    
    private func playSound(withName name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = audioPlayer else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func congratulationsSounds(soundCase: SoundCases) {
            playSound(withName: soundCase.description)
    }
}
