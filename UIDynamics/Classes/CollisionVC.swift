//
//  CollisionVC.swift
//  UIDynamics
//
//  Created by Yudiz Solutions on 06/08/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class CollisionVC: UIViewController {

    @IBOutlet var squareViews: [UIView]!
    @IBOutlet weak var switchCollision: UISwitch!
    
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    
    var dynamicItemBehavior: UIDynamicItemBehavior!

    var viewFrames : [CGRect] = []
    var selfFrame   = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

}


// MARK:- Functions
extension CollisionVC {
    
    func prepareUI() {
        selfFrame = self.view.frame
        for view in squareViews {
            viewFrames.append(view.frame)
        }
        
        resetViewFrames()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        switchCollision.isOn = false
    }
    
    func resetViewFrames() {
        for (idx, elemnent) in squareViews.enumerated() {
            elemnent.frame = viewFrames[idx]
        }
    }
    
    func addGravityWithCollision() {
        gravityBehavior = UIGravityBehavior(items: squareViews)
        collisionBehavior = UICollisionBehavior(items: squareViews)
//        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
//        collisionBehavior.collisionMode = .boundaries
//        collisionBehavior.collisionMode = .items
        collisionBehavior.collisionMode = .everything
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: selfFrame.maxY, left: selfFrame.maxX, bottom: selfFrame.maxY, right: selfFrame.maxX))
        
        dynamicAnimator.addBehavior(gravityBehavior)
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    
}


// MARK:- Actions
extension CollisionVC {
    
    // To pop a view controller
    @IBAction func popViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Button Actions
    @IBAction func switchCollisionTapped(_ sender: UISwitch) {
        if (sender.isOn) {
            addGravityWithCollision()
        } else {
            resetViewFrames()
            dynamicAnimator.removeAllBehaviors()
        }
    }
}
