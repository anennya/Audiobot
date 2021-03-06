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
import Accounts
import Social
import SwifteriOS


class FirstViewController: UIViewController {
    var swifter: Swifter
    var tweets : [JSONValue] = []
    
    // Default to using the iOS account framework for handling twitter auth
    let useACAccount = true
    
    required init(coder aDecoder: NSCoder) {
        self.swifter = Swifter(consumerKey: "SXvD2wyU1FwHXKsBQazcO1dhX", consumerSecret: "xnCD8hRNhkx9jvOfr4rrYHpTSO5vfHcfe7u3dPddFK2EmEZPCA")
        super.init(coder: aDecoder)
    }


    @IBAction func twitterLogin(sender: UIButton) {
        let failureHandler: ((NSError) -> Void) = {
            error in
            
            self.alertWithTitle("Error", message: error.localizedDescription)
        }
        
        if useACAccount {
            let accountStore = ACAccountStore()
            let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
            
            // Prompt the user for permission to their twitter account stored in the phone's settings
            accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
                granted, error in
                
                if granted {
                    let twitterAccounts = accountStore.accountsWithAccountType(accountType)
                    
                    if twitterAccounts?.count == 0
                    {
                        self.alertWithTitle("Error", message: "There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                    }
                    else {
                        let twitterAccount = twitterAccounts[0] as! ACAccount
                        self.swifter = Swifter(account: twitterAccount)
                        self.fetchTwitterHomeStream()
                    }
                }
                else {
                    self.alertWithTitle("Error", message: error.localizedDescription)
                }
            }
        }
        else {
            swifter.authorizeWithCallbackURL(NSURL(string: "swifter://success")!, success: {
                accessToken, response in
                
                self.fetchTwitterHomeStream()
                
                },failure: failureHandler
            )
        }
    }
    
    
    @IBOutlet weak var textView: UITextView!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    @IBAction func textToSpeech(sender: UIButton) {
        myUtterance =  AVSpeechUtterance(string: textView.text)
        myUtterance.rate = 0.2
        synth.speakUtterance(myUtterance)

    }
    
    func fetchTwitterHomeStream() {
        let failureHandler: ((NSError) -> Void) = {
            error in
            self.alertWithTitle("Error", message: error.localizedDescription)
        }
        
        self.swifter.getStatusesHomeTimelineWithCount(20, success: {
            (statuses: [JSONValue]?) in
            
            // Successfully fetched timeline, so lets create and push the table view
           // let tweetsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
            
            if statuses != nil {
                self.tweets = statuses!
                self.myUtterance = AVSpeechUtterance(string: self.tweets[1]["text"].string)
            }
            
            }, failure: failureHandler)
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertWithTitle(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }



}

