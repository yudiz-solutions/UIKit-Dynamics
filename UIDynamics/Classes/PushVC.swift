//
//  PushVC.swift
//  UIDynamics
//
//  Created by Yudiz Solutions on 06/08/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class PushVC: UIViewController {

    /// IBOutlets
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var switchPush: UISwitch!
    
    /// Variables
    var originalRect: CGRect!
    
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    var pushBehavior: UIPushBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

}


// MARK: - Functions
extension PushVC {
    
    func prepareUI() {
        originalRect = squareView.frame
        squareView.frame = originalRect
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        switchPush.isOn = false
    }
    
    
    // MARK:- Behavior Setter Methods
    func addGravity() {
        gravityBehavior  = UIGravityBehavior(items: [squareView])
        collisionBehavior = UICollisionBehavior(items: [squareView])                                        // Collision with Floor
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(gravityBehavior)
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    
    func addPushBehavior() {
        dynamicAnimator.removeAllBehaviors()
        pushBehavior = UIPushBehavior(items: [squareView], mode: .continuous)
        pushBehavior.magnitude = 0.1
        pushBehavior.pushDirection = CGVector(dx: 0, dy: -1)                                                // To up side
        pushBehavior.setTargetOffsetFromCenter(UIOffset(horizontal: -10, vertical: 0), for: squareView)     // Will spin Clockwise cause of offset
//        pushBehavior.pushDirection = CGVector(dx: 1, dy: 0)                                               // To left side
//        pushBehavior.setTargetOffsetFromCenter(UIOffset(horizontal: 0, vertical: 10), for: squareView)    // Will spin Clockwise cause of offset
        
        collisionBehavior = UICollisionBehavior(items: [squareView])
        collisionBehavior.addBoundary(withIdentifier: "topBoundary" as NSCopying, from: CGPoint(x: 0, y: 64), to: CGPoint(x: self.view.frame.size.width, y: 64))

//        collisionBehavior.translatesReferenceBoundsIntoBoundary = true // It will consider screen as boundary
        dynamicAnimator.addBehavior(pushBehavior)
        dynamicAnimator.addBehavior(collisionBehavior)
    }
}


// MARK: - Actions
extension PushVC {
    
    // To pop a view controller
    @IBAction func popViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Button Actions
    @IBAction func swtichPushTapped(_ sender: UISwitch) {
        if (sender.isOn) {
            addPushBehavior()
        } else {
            addGravity()
        }
    }
}
