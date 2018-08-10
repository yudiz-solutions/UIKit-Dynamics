//
//  SnapVC.swift
//  UIDynamics
//
//  Created by Yudiz Solutions on 06/08/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class SnapVC: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!      // Buttons which behaves in UISnapBhavior
    @IBOutlet var btnRepeat: UIButton!      // Button to repeat snap behavior
    
    var dynamicAnimator: UIDynamicAnimator! // Dynamic animator object to perform physics-related animations
    var snapBehavior: UISnapBehavior!       // Snap behavior object

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
}

// MARK:- Functions
extension SnapVC {
    
    func prepareUI() {
        view.layoutIfNeeded()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        addSnap()
    }
    
    func addSnap() {
        for button in buttons {
            let originalPosition = button.center
            button.center = CGPoint(x: self.view.frame.width / 2, y: -button.frame.height)
            snapBehavior = UISnapBehavior(item: button, snapTo: originalPosition)
            snapBehavior.damping = 0.2      // amount of oscillation of dynamic item
            dynamicAnimator.addBehavior(snapBehavior)
        }
    }
}

// MARK:- Action methods
extension SnapVC {
    
    // To pop a view controller
    @IBAction func popViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func repeatAction(_ sender: UIButton) {
        dynamicAnimator.removeAllBehaviors()
        addSnap()
    }
}
