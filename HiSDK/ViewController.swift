//
//  ViewController.swift
//  HiSDK
//
//  Created by TuanAnh on 7/26/17.
//  Copyright © 2017 TuanAnh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let spController = SupportController(nibName: "SupportController", bundle: nil);
        self.present(spController, animated: true, completion: nil);
    }
    
    


}

