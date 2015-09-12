//
//  AppDelegate.swift
//  Audiobot
//
//  Created by Arjun Sundararajan on 9/5/15.
//  Copyright (c) 2015 Arjun Sundararajan. All rights reserved.
//

import UIKit
import SwifteriOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        Swifter.handleOpenURL(url)
        
        return true
    }

}

