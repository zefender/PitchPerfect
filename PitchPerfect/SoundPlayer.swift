//
//  SoundPlayer.swift
//  PitchPerfect
//
//  Created by Кузяев Максим on 28.06.15.
//  Copyright (c) 2015 zefender. All rights reserved.
//

import UIKit
import AVFoundation

// Class for playing with custom effects
// decouples this logic from ViewControllers
class SoundPlayer {
    var audioPlayer:AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var recorderedAudioPath: NSURL!
    var audioFile: AVAudioFile!
    

    init()  {
        audioEngine = AVAudioEngine()
    }
    
    func playSoundSlowly() -> Void {
        playSoundWithRate(0.5)
    }
    

    func playSoundFaster() -> Void {
        playSoundWithRate(1.5)
    }
    
    func playSoundWithRate(rate: Float) -> Void {
        stopPlayback()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recorderedAudioPath, error: nil)
        audioPlayer.rate = rate
        audioPlayer.enableRate = true
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    func playLikeChipmunk() -> Void {
        playWithPitch(1000)
    }
    
    func playLikeDartVader() -> Void {
        playWithPitch(-1000)
    }
    
    func playWithPitch(pitch: Float) -> Void {
        stopPlayback()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioFile = AVAudioFile(forReading: recorderedAudioPath, error: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func stopPlayback()     {
        // Don't stop if audioPlayer is nil
        if(audioPlayer != nil) {
            audioPlayer.stop()
        }
        
        audioEngine.stop()
        audioEngine.reset()
    }
}
