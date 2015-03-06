//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jesstern Rays on 3/3/15.
//  Copyright (c) 2015 Jesstern Rays. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // toggle display text "recording..."
        recordingInProgress.hidden = false
        recordButton.hidden = true
        stopButton.hidden = false
        // TODO: record user's voice 
        println("You clicked on the record button")
    }
    @IBAction func stopAudio(sender: UIButton) {
        recordButton.hidden = false
        stopButton.hidden = true
        recordingInProgress.hidden = true
    }

}

