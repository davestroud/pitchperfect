    //
//  PlaySoundsViewController.swift
//  pitchperfect
//
//  Created by John David Stroud on 6/26/15.
//  Copyright (c) 2015 John David Stroud. All rights reserved.
//

import UIKit
import AVFoundation
    
class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
        func playAudioWithVariablePitch(pitch: Float)   {
            audioPlayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            
        var audioPlayerNode  = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine.attachNode(changePitchEffect)
            
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            
           audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
            
            audioPlayerNode.play()
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
