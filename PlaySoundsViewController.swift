//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jesstern Rays on 6/3/15.
//  Copyright (c) 2015 Jesstern Rays. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // file path to audio clip
        if let filePath = NSBundle.mainBundle().pathForResource("sound", ofType: ".mp3") {
            println(filePath)
            var filePathURL = NSURL(string: filePath)
            // create an instance of AVAudioPlayer
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL!, error: nil)
        } else {
            println("The file does not exist")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundSlow(sender: UIButton) {
        // TODO: play audio clip
        audioPlayer.play()
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
