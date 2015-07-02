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
    
    
    func playerSpeed(customRate: Float)  {
        audioPlayer.stop()
        audioPlayer.rate = customRate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        stopAudio(sender)
        playerSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        stopAudio(sender)
        playerSpeed(2.0)
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
            
            // plays the recorded sound
            audioPlayerNode.play()
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)

    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
