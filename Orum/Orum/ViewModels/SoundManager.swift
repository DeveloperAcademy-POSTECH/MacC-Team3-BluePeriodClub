//
//  SoundManager.swift
//  Orum
//
//  Created by Youngbin Choi on 10/24/23.
//

import SwiftUI
import AVKit
import AVFoundation

class SoundManager: NSObject, AVAudioPlayerDelegate {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    var completion: (() -> Void)?
    
    override private init() {
            super.init()
            setupAudioSession()
        }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up AVAudioSession: \(error.localizedDescription)")
        }
    }

    func playSound(sound: String, completion: (() -> Void)?) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: ".m4a") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
            self.completion = completion
        } catch {
            print(error.localizedDescription)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // 사운드 재생이 끝났을 때 호출되는 메서드
        completion?()
        completion = nil
    }
}
