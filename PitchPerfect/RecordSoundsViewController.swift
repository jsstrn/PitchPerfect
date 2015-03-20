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
    var userHasPausedRecording: Bool = false
    var recordingStatus : Int = 1
    // recordingStatus
    // 1 - user is starting a new recording
    // 2 - user is in the middle of recording
    // 3 - user has paused recording
    
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
        recordingStatus = 1
        displayManager()
    }
    
    func displayManager() {
        switch recordingStatus {
        // user is starting a new recording
        case 1:
            recordLabel.text = "Tap to record"
            recordButton.enabled = true
            pauseButton.enabled = true
            stopButton.enabled = true
            pauseButton.hidden = true
            stopButton.hidden = true
            
        // user is in the middle of recording
        case 2:
            recordLabel.text = "Recording"
            recordButton.enabled = false
            pauseButton.enabled = true
            stopButton.enabled = true
            pauseButton.hidden = false
            stopButton.hidden = false
            
        // user has paused recording
        case 3:
            recordLabel.text = "Tap to resume"
            recordButton.enabled = true
            pauseButton.enabled = false
            stopButton.enabled = true
            pauseButton.hidden = false
            stopButton.hidden = false
        default:
            break
        }
    }

    @IBAction func startRecording(sender: UIButton) {
        recordingStatus = 2
        displayManager()
        
        if userHasPausedRecording {
            // continue with current recording
            audioRecorder.record()
        } else {
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
            
            // start a new recording
            activateAudioSession()
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.record()
        }
    }
    
    @IBAction func pauseRecording(sender: UIButton) {
        audioRecorder.pause()
        userHasPausedRecording = true
        recordingStatus = 3
        displayManager()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder.stop()
        deactivateAudioSession()
        userHasPausedRecording = false
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