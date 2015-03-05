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
        if (recordingInProgress.hidden) {
            recordingInProgress.hidden = false
        } else {
            recordingInProgress.hidden = true
        }
        // TODO: record user's voice 
        println("You clicked on the record button")
    }

}

