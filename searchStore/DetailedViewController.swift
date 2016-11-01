//
//  DetailedViewController.swift
//  searchStore
//
//  Created by Yiqin Yao on 01/11/2016.
//  Copyright © 2016 Yiqin Yao. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentationController(forPresented presented: UIViewController, // 将要present的view controller
                                presenting: UIViewController?, 
                                source: UIViewController //The view controller whose present(_:animated:completion:) method was called to initiate the presentation process.
                                ) -> UIPresentationController?
    {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
