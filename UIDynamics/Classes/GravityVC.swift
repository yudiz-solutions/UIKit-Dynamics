//
//  GravityVC.swift
//  UIDynamics
//
//  Created by Yudiz Solutions on 06/08/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class GravityVC: UIViewController {
    
    /// IBOutlets
    @IBOutlet var squareView: UIView!
    @IBOutlet var switchGravity: UISwitch!
    @IBOutlet var switchBounce: UISwitch!
    
    /// Variables
    var originalRect: CGRect!
    
    var dynamicAnimator   : UIDynamicAnimator!
    var gravityBehavior   : UIGravityBehavior!
    var collisionBehavior : UICollisionBehavior!
    var bouncingBehavior  : UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

}

// MARK:- Functions
extension GravityVC {
    
    func prepareUI() {
        originalRect = squareView.frame
        squareView.frame = originalRect
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        switchGravity.isOn = false
        switchBounce.isOn = false
    }
    
    func addGravity() {
        gravityBehavior  = UIGravityBehavior(items: [squareView])
        dynamicAnimator.addBehavior(gravityBehavior)
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: 1)       // For Down side
//        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: -1)    // For Up side
//        gravityBehavior.gravityDirection = CGVector(dx: 1, dy: 0)     // For left side
//        gravityBehavior.gravityDirection = CGVector(dx: -1, dy: 0)    // For right side

//        gravityBehavior.angle = CGFloat(90 * (Double.pi/180)) // 90 Degree into RADIANS
//        gravityBehavior.magnitude = CGFloat(5)                // Gravity force
//        gravityBehavior.setAngle(CGFloat(180 * (Double.pi/180)), magnitude: 0.2)
    }
    
    func addBounce() {
        collisionBehavior = UICollisionBehavior(items: [squareView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        // Another way to set boundaries, you have to add boundary one by one
//        collisionBehavior.addBoundary(withIdentifier: "bottomBoundary" as NSCopying, from: CGPoint(x: 0, y: self.view.frame.size.height), to: CGPoint(x: self.view.frame.size.width, y: self.view.frame.size.height))
        
        dynamicAnimator.addBehavior(collisionBehavior)
        
        bouncingBehavior = UIDynamicItemBehavior(items: [squareView])
        bouncingBehavior.elasticity = 0.70
        dynamicAnimator.addBehavior(bouncingBehavior)
    }
}


// MARK:- Actions
extension GravityVC {
    
    // To pop a view controller
    @IBAction func popViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchGravityTapped(_ sender: UISwitch) {
        if (sender.isOn) {
            if switchBounce.isOn {
                addBounce()
            }else {
                dynamicAnimator.removeAllBehaviors()
            }
            addGravity()
        } else {
            squareView.frame = originalRect
            dynamicAnimator.removeAllBehaviors()
        }
    }
}
