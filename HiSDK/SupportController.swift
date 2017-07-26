//
//  SupportController.swift
//  HiSDK
//
//  Created by TuanAnh on 7/26/17.
//  Copyright © 2017 TuanAnh. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SupportController: UIViewController ,GADNativeExpressAdViewDelegate, GADVideoControllerDelegate , GADRewardBasedVideoAdDelegate, UIAlertViewDelegate{

    @IBOutlet weak var nativeExpressAdView: GADNativeExpressAdView!
     var rewardBasedVideo: GADRewardBasedVideoAd?
     var interstitial: GADInterstitial!
    @IBOutlet weak var spLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedVideo?.delegate = self
        
        
        
        if  rewardBasedVideo?.isReady == false {
            rewardBasedVideo?.load(GADRequest(),
                                   withAdUnitID: Admob.videoUnitId)
          
        }
        
        interstitial = GADInterstitial(adUnitID: Admob.interstitialUnitId)
        let requestInters = GADRequest()
        requestInters.testDevices = [ kGADSimulatorID]
        interstitial.load(requestInters)
        
        
        self.spLabel.adjustsFontSizeToFitWidth = true
        nativeExpressAdView.adUnitID = Admob.nativeUnitId
        nativeExpressAdView.rootViewController = self
        nativeExpressAdView.delegate = self
        
        
        // The video options object can be used to control the initial mute state of video assets.
        // By default, they start muted.
        let nativeOptions = GADNativeAdViewAdOptions()
        
        let videoOptions = GADVideoOptions()
        videoOptions.startMuted = true
        nativeExpressAdView.isAutoloadEnabled = true
        nativeExpressAdView.setAdOptions([videoOptions,nativeOptions])
        nativeExpressAdView.videoController.delegate = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        nativeExpressAdView.load(request)

    }
    
    
    @IBAction func viewMoreAds(_ sender: Any) {
        
        if rewardBasedVideo?.isReady == true {
            rewardBasedVideo?.present(fromRootViewController: self)
        }else
        {
            displayInterstitialAds()
        }
    }
    
    func displayInterstitialAds()
    {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    

    @IBOutlet weak var playGame: UIButton!
    
    @IBAction func playGameDidTap(_ sender: Any) {
        
        
        
        
    }
    
    // MARK: - GADNativeExpressAdViewDelegate
    
    func nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
        
        
        if nativeExpressAdView.videoController.hasVideoContent() {
            print("Received an ad with a video asset.")
        } else {
            print("Received an ad without a video asset.")
        }
    }
    
    // MARK: - GADVideoControllerDelegate
    
    func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
        
        
        
        print("The video asset has completed playback.")
        
    }
    
    // MARK: GADRewardBasedVideoAdDelegate implementation
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
       
        print("Reward based video ad failed to load: \(error.localizedDescription)")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
     
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        
    }

    


}
