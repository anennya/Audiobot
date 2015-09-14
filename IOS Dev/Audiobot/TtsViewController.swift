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
    @IBOutlet weak var speakBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func PauseSpeech(sender: UIButton) {
        synth.pauseSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        self.animateActionButtonAppearance(false)
    }
    
    
    @IBAction func StopSpeech(sender: UIButton) {
        synth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        self.animateActionButtonAppearance(false)
    }
    
    @IBAction func TextToSpeech(sender: UIButton) {
        var actualText = ""
        var toSpeak = ""
        if !synth.speaking{
        
            for tweet in tweets{
                let text = tweet["text"]
                let user = tweet["user"]["name"]
                
                if let myString = text.string {
                    var myArray : [String] = myString.componentsSeparatedByString("http")
                    println(myArray)
                    actualText = myArray[0] 
                }
                else {
                    continue
                }
                
                if let myString = user.string {
                    toSpeak = myString + "  said " + actualText
                }
                    myUtterance = AVSpeechUtterance(string: toSpeak)
                    myUtterance.rate = 0.05
                    synth.speakUtterance(myUtterance)
            }
        }
        else{
            synth.continueSpeaking()
        }
        self.animateActionButtonAppearance(true)

    }
        
        func animateActionButtonAppearance(shouldHideSpeakButton: Bool) {
            var speakButtonAlphaValue: CGFloat = 1.0
            var pauseStopButtonsAlphaValue: CGFloat = 0.0
            
            if shouldHideSpeakButton {
                speakButtonAlphaValue = 0.0
                pauseStopButtonsAlphaValue = 1.0
            }
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.speakBtn.alpha = speakButtonAlphaValue
                
                self.pauseBtn.alpha = pauseStopButtonsAlphaValue
                
                self.stopBtn.alpha = pauseStopButtonsAlphaValue
            })
        }
        
 
}