//
//  RecordSoundsViewController.swift
//  pitchperfect
//
//  Created by John David Stroud on 6/26/15.
//  Copyright (c) 2015 John David Stroud. All rights reserved.
//

import UIKit
import AVFoundation

var audioRecorder:AVAudioRecorder!
var recordedAudio:RecordedAudio!



class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButton.hidden = true
        recordingInProgress.text = "tap to record"
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        stopButton.hidden = false
        recordingInProgress.hidden = false

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        recordingInProgress.text = "Recording in Progress...."
       
    }
    
        func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
            if (flag) {
                recordedAudio = RecordedAudio()
                recordedAudio.filePathUrl = recorder.url
                recordedAudio.title = recorder.url.lastPathComponent
                self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            } else {
                println("Recording was not successful.")
                recordButton.enabled = true
                stopButton.hidden = true
            }
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        recordingInProgress.text = "Finished Recording"
    }
}


