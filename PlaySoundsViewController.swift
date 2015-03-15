//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jesstern Rays on 6/3/15.
//  Copyright (c) 2015 Jesstern Rays. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var receiveRecordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // create an instance of AVAudioPlayer
        audioPlayer = AVAudioPlayer(contentsOfURL: receiveRecordedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true // enable rate
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveRecordedAudio.filePathURL, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound() {
        audioPlayer.stop() // stop audio clip
        audioPlayer.currentTime = 0.0 // reset play head
        audioPlayer.play() // play audio clip
    }

    @IBAction func playSoundSlow(sender: UIButton) {
        audioPlayer.rate = 0.5 // change rate of audio clip
        stopAndResetAudioEngine()
        playSound()
    }

    @IBAction func playSoundFast(sender: UIButton) {
        audioPlayer.rate = 1.5 // change rate of audio clip
        stopAndResetAudioEngine()
        playSound()
    }
    
    func stopAndResetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop() // stop audio clip
        stopAndResetAudioEngine()
    }
    
    func playSoundsWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        stopAndResetAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
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

    @IBAction func playSoundsChipmunk(sender: UIButton) {
        playSoundsWithVariablePitch(1000)
    }
    
    @IBAction func playSoundDarthVader(sender: UIButton) {
        playSoundsWithVariablePitch(-1000)
    }
}
