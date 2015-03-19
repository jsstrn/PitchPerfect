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
    
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var receiveRecordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveRecordedAudio.filePathURL, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playSoundSlow(sender: UIButton) {
        playSound(playSoundWithVariableRate(0.5))
    }

    @IBAction func playSoundFast(sender: UIButton) {
        playSound(playSoundWithVariableRate(1.5))
    }
    
    @IBAction func stopSound(sender: UIButton) {
        stopAndResetAudioEngine()
    }

    @IBAction func playSoundChipmunk(sender: UIButton) {
        playSound(playSoundWithVariablePitch(1000))
    }
    
    @IBAction func playSoundDarthVader(sender: UIButton) {
        playSound(playSoundWithVariablePitch(-1000))
    }
    
    @IBAction func playSoundReverb(sender: UIButton) {
        playSound(playSoundWithVariableReverb(100))
    }
    
    func playSound(changeSoundEffect: AVAudioUnit) {
        stopAndResetAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(changeSoundEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeSoundEffect, format: nil)
        audioEngine.connect(changeSoundEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func playSoundWithVariableRate(rate: Float) -> AVAudioUnitTimePitch {
        var changeRateEffect = AVAudioUnitTimePitch()
        changeRateEffect.rate = rate
        return changeRateEffect
    }
    
    func playSoundWithVariablePitch(pitch: Float) -> AVAudioUnitTimePitch {
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        return changePitchEffect
    }
    
    func playSoundWithVariableReverb(wetDryMix: Float) -> AVAudioUnitReverb {
        var changeOverlapEffect = AVAudioUnitReverb()
        changeOverlapEffect.wetDryMix = wetDryMix
        return changeOverlapEffect
    }
    
    func stopAndResetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
}
