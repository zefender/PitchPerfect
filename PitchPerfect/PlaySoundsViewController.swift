//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Кузяев Максим on 28.06.15.
//  Copyright (c) 2015 zefender. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var soundPlayer: SoundPlayer!
    var recivedAudio: RecorderedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        soundPlayer = SoundPlayer()
        soundPlayer.recorderedAudioPath = recivedAudio.filePathUrl
    }
    
    @IBAction func slowButtonDidTapped(sender: AnyObject) {
        soundPlayer.playSoundSlowly()
    }

    @IBAction func fasterButtonDidTapped(sender: AnyObject) {
        soundPlayer.playSoundFaster()
    }
    
    @IBAction func chipmunkButtonDidTapped(sender: AnyObject) {
         soundPlayer.playLikeChipmunk()
    }
    
    @IBAction func darthVaderButtonDidTapped(sender: AnyObject) {
        soundPlayer.playLikeDartVader()
    }
}
