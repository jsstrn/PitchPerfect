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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // file path to audio clip
        if let filePath = NSBundle.mainBundle().pathForResource("sound", ofType: ".mp3") {
            
            // convert String to NSURL
            var filePathURL = NSURL(string: filePath)

            // create an instance of AVAudioPlayer
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL!, error: nil)
            
            // enable rate
            audioPlayer.enableRate = true
        } else {
            println("The file does not exist")
        }
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
        playSound()
    }

    @IBAction func playSoundFast(sender: UIButton) {
        audioPlayer.rate = 1.5 // change rate of audio clip
        playSound()
    }
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop() // stop audio clip
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
