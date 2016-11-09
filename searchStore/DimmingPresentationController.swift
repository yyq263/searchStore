//
//  DimmingPresentationController.swift
//  searchStore
//
//  Created by Yiqin Yao on 01/11/2016.
//  Copyright © 2016 Yiqin Yao. All rights reserved.
//

import UIKit
class DimmingPresentationController: UIPresentationController {
    lazy var dimmingView = GradientView(frame: CGRect.zero) //initialization
    
//    override var shouldRemovePresentersView: Bool { //The standard presentation controller removed the underlying view from the screen, making it appear as if the Detail pop-up had a solid black background
//        return false
//    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)
        dimmingView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin()  {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
                }, completion: nil)
        }
    }
    
    
    
}
