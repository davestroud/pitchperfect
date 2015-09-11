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
        // sets up the view and plays the contents of the path
        super.viewDidLoad()
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    func playerSpeed(customRate: Float)  {
        // sets the playing speed for playSlowAudion and PlayFastAudio
        audioPlayer.rate = customRate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        // plays audio slow
        stopAudio(sender)
        playerSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {    
        // plays audio fast
        stopAudio(sender)
        playerSpeed(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
        
    func playAudioWithVariablePitch(pitch: Float)   {
        // allows audio to be played and variable pitches
       stopAudio(self)
        
        var audioPlayerNode  = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.startAndReturnError()
        } catch _ {
        }
        
        // plays the recorded sound
        audioPlayerNode.play()
    }

    @IBAction func stopAudio(sender: AnyObject) {
        // stops the audioPlayer and audioEngine
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
