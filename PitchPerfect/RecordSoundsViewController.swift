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
    
    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
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
        recordButton.enabled = true // enable record button
        stopButton.hidden = true // show stop button
        stopButton.enabled = true // enable stop button
        recordingInProgress.hidden = true // hide recording label
    }

    @IBAction func recordAudio(sender: UIButton) {
        tapToRecord.hidden = true // hide instructions
        recordingInProgress.hidden = false // show recording label
        stopButton.hidden = false // show stop button
        recordButton.enabled = false // disable record button
        
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
            recordingInProgress.hidden = true // hide recording label
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsViewController: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            var data = sender as RecordedAudio
            playSoundsViewController.receiveRecordedAudio = data
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioRecorder.stop() // stop recording
        deactivateAudioSession() // close the audio session
        stopButton.enabled = false // disable stop button
        recordButton.enabled = true // enable record button
        recordingInProgress.hidden = true // hide recording label
        tapToRecord.hidden = false // show instructions
    }

} // end of RecordSoundsViewController