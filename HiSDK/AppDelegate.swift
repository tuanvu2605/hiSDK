//
//  AppDelegate.swift
//  HiSDK
//
//  Created by TuanAnh on 7/26/17.
//  Copyright © 2017 TuanAnh. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: Admob.appId)
        return true
    }



}

