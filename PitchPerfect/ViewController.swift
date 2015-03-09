//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jesstern Rays on 3/3/15.
//  Copyright (c) 2015 Jesstern Rays. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* Properties */
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
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
        // enable record button
        recordButton.enabled = true
        
        // show and enable stop button
        stopButton.hidden = true
        stopButton.enabled = true
        
        // hide recording label
        recordingInProgress.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        // show recording label
        recordingInProgress.hidden = false
        
        // show stop button
        stopButton.hidden = false
        
        // disable record button
        recordButton.enabled = false
        
        // TODO: record user's voice

    }
    @IBAction func stopAudio(sender: UIButton) {
        // disable stop button
        stopButton.enabled = false
        
        // hide recording label
        recordingInProgress.hidden = true
    }

}

