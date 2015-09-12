//
//  TtsViewController.swift
//  Audiobot
//
//  Created by Arjun Sundararajan on 9/10/15.
//  Copyright (c) 2015 Arjun Sundararajan. All rights reserved.
//

import UIKit
import Accounts
import Social
import SwifteriOS
import AVFoundation


class TtsViewController: UIViewController {
    var tweets : [JSONValue] = []
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func TextToSpeech(sender: UIButton) {
        for tweet in tweets{
            myUtterance = AVSpeechUtterance(string: tweet["text"].string)
            myUtterance.rate = 0.1
            synth.speakUtterance(myUtterance)

        }
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
