//
//  DimmingPresentationController.swift
//  searchStore
//
//  Created by Yiqin Yao on 01/11/2016.
//  Copyright © 2016 Yiqin Yao. All rights reserved.
//

import UIKit
class DimmingPresentationController: UIPresentationController {
    
    override var shouldRemovePresentersView: Bool { //The standard presentation controller removed the underlying view from the screen, making it appear as if the Detail pop-up had a solid black background
        return false
    }
}
