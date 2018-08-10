//
//  AttachmentVC.swift
//  UIDynamics
//
//  Created by Yudiz Solutions on 06/08/18.
//  Copyright © 2018 Yudiz Solutions. All rights reserved.
//

import UIKit

class AttachmentVC: UIViewController {

    @IBOutlet weak var switchAttachment: UISwitch!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var attachedView: UIView!
    
    var dynamicAnimator    : UIDynamicAnimator!     // to animate dynamic items
    var gravityBehavior    : UIGravityBehavior!     // to apply gravity-like force to our dynamics items
    var attachmentBehavior : UIAttachmentBehavior!  // to relate an item or items to and anchor point
    
    let originalRect = CGRect(x: 16, y: 130, width: 60, height: 60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

}


// MARK:- Functions
extension AttachmentVC {
    
    func prepareUI() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        switchAttachment.isOn = false
    }
    
    // MARK:- Behavior Setter Methods
    func addGravityWithAttachment() {
        gravityBehavior = UIGravityBehavior(items: [attachedView])  // add gravity to attachedView
        attachmentBehavior = UIAttachmentBehavior(item: attachedView, attachedToAnchor: anchorView.frame.origin)
        attachmentBehavior.damping = 0.5
        attachmentBehavior.attachmentRange = UIFloatRange(minimum: 10, maximum: 20)
        dynamicAnimator.addBehavior(gravityBehavior)                // it is reduction in amplitude in oscillation
        dynamicAnimator.addBehavior(attachmentBehavior)             // add behavior to animator
    }
}


// MARK:- Actions
extension AttachmentVC {
    
    // To pop a view controller
    @IBAction func popViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Button Actions
    @IBAction func switchAttachmentTapped(_ sender: UISwitch) {
        if (sender.isOn) {
            addGravityWithAttachment()
        } else {
            dynamicAnimator.removeAllBehaviors()
            attachedView.frame = originalRect
        }
    }
}             
