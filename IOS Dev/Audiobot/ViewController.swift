//
//  ViewController.swift
//  Audiobot
//
//  Created by Arjun Sundararajan on 9/5/15.
//  Copyright (c) 2015 Arjun Sundararajan. All rights reserved.
//

import UIKit
import AVFoundation
import SwifteriOS

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    @IBAction func textToSpeech(sender: UIButton) {
        myUtterance =  AVSpeechUtterance(string: textView.text)
        myUtterance.rate = 0.2
        synth.speakUtterance(myUtterance)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

