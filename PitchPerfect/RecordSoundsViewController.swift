//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jesstern Rays on 3/3/15.
//  Copyright (c) 2015 Jesstern Rays. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // Properties
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var isInTheMiddleOfRecording: Bool = false
    
    // Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        recordLabel.text = "Tap to record"
        recordButton.enabled = true // enable record button
        pauseButton.hidden = true
        pauseButton.enabled = true
        stopButton.hidden = true // show stop button
        stopButton.enabled = true // enable stop button
    }

    @IBAction func startRecording(sender: UIButton) {
        recordLabel.text = "Recording"
        stopButton.hidden = false // show stop button
        pauseButton.hidden = false
        recordButton.enabled = false // disable record button
        
        if !isInTheMiddleOfRecording {
            // create a new recording
            
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
            
            activateAudioSession() // start audio session for recording
            
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.record()
        } else {
            // continue recording
            audioRecorder.record()
            pauseButton.hidden = false
            pauseButton.enabled = true
        }
    }
    
    @IBAction func pauseRecording(sender: UIButton) {
        audioRecorder.pause()
        recordButton.enabled = true
        stopButton.hidden = false
        pauseButton.enabled = false
        isInTheMiddleOfRecording = true
        recordLabel.text = "Tap to resume"
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder.stop() // stop recording
        deactivateAudioSession() // close the audio session
        stopButton.enabled = false // disable stop button
        pauseButton.hidden = true
        recordButton.enabled = true // enable record button
        recordLabel.text = "Tap to record"
        isInTheMiddleOfRecording = false
    }
    
    func activateAudioSession() {
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryRecord, error: nil)
    }
    
    func deactivateAudioSession() {
        AVAudioSession.sharedInstance().setActive(false, error: nil) // close the audio session
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            // save recorded audio
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent! , filePathURL: recorder.url)
            // move to next scene (segue)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("Recording was not successful!")
            recordButton.enabled = true // enable record button
            recordLabel.text = "Tap to record"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsViewController: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            var data = sender as RecordedAudio
            playSoundsViewController.receiveRecordedAudio = data
        }
    }

} // end of RecordSoundsViewController