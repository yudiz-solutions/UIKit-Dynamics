//
//  ViewController.swift
//  UIDynamics
//
//  Created by Yudiz Solutions on 06/08/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    /// IBOutlets
    @IBOutlet var btnBehavior: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for (index, button) in btnBehavior.enumerated() {
            button.tag = index
        }
    }
}

// MARK:- Actions
extension HomeVC {
        
    @IBAction func behaviorTapper(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.performSegue(withIdentifier: "pushSegue", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "collisionSegue", sender: nil)
        case 3:
            self.performSegue(withIdentifier: "snapSegue", sender: nil)
        case 4:
            self.performSegue(withIdentifier: "attachmentSegue", sender: nil)
        default:
            self.performSegue(withIdentifier: "gravitySegue", sender: nil)
        }
    }
    
}
