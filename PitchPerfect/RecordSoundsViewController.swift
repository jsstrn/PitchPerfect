//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jesstern Rays on 3/3/15.
//  Copyright (c) 2015 Jesstern Rays. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    /* Properties */
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    var audioRecorder: AVAudioRecorder!
    
    /* Methods */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true // enable record button
        stopButton.hidden = true // show stop button
        stopButton.enabled = true // enable stop button
        recordingInProgress.hidden = true // hide recording label
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        recordingInProgress.hidden = false // show recording label
        stopButton.hidden = false // show stop button
        recordButton.enabled = false // disable record button
        
        // TODO: What are these frameworks? 
        // TODO: NSSearchPathForDirectoriesInDomains
        // TODO: NSURL.fileURLWithPathComponents
        // TODO: AVAudioSession, setCategory
        // TODO: meteringEnabled
        
        // get the main app directory
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // create the audio file name with datetime stamp
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        
        // the string for file path and the audio file, converted to NSURL
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.record()

    }
    @IBAction func stopAudio(sender: UIButton) {
        audioRecorder.stop() // stop recording
        stopButton.enabled = false // disable stop button
        recordingInProgress.hidden = true // hide recording label
    }

}

