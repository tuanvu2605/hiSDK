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
        iapSetup()
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: Admob.appId)
        return true
    }
    
    func iapSetup()
    {
        if(IAPShare.sharedHelper().iap == nil)
        {
            var dataSet = Set<String>()
            dataSet.insert(IAP.removeAdsIAPID)
            IAPShare.sharedHelper().iap = IAPHelper(productIdentifiers: dataSet)
            
            
            IAPShare.sharedHelper().iap.requestProducts(completion: { (req, res) in
                
                print("products \(IAPShare.sharedHelper().iap.products)")
                
            })
            
        }
    }



}

