//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Кузяев Максим on 27.06.15.
//  Copyright (c) 2015 zefender. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    var recorderedAudio: RecorderedAudio!
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
        
    override func viewWillAppear(animated: Bool) {
        switchRecordingControls(false)
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        switchRecordingControls(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let pathArray = [dirPath, "myRecording"]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            recorderedAudio = RecorderedAudio()
            recorderedAudio.filePathUrl = recorder.url
            recorderedAudio.title = recorder.url.lastPathComponent
            
            performSegueWithIdentifier("playSoundSegue", sender: recorderedAudio)
        }
        else {
            var errorAlertController = UIAlertController(title: "Error", message: "Some error has occured while recording", preferredStyle:
                UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { action -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            errorAlertController.addAction(OKAction)
            self.presentViewController(errorAlertController, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "playSoundSegue") {
            let playSoundViewController: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecorderedAudio
            playSoundViewController.recivedAudio = data 
        }
    }
    
    @IBAction func stopButtonDidTapped(sender: AnyObject) {
        switchRecordingControls(false)
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    // Swithes the state of recordings
    func switchRecordingControls(isRecording: Bool) {
        recordLabel.text = !isRecording ? "Tap to record" : "recording"
        stopButton.hidden = !isRecording
    }
}

