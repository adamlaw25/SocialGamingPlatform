//
//  SliderViewController.swift
//  SocialGamingPlatform
//
//  Created by Dennis Lin on 11/15/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {
    
    
    @IBOutlet weak var score_label: UILabel!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeUp = UISwipeGestureRecognizer(target: self, action: Selector(("swipeResponse:")))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector(("swipeResponse:")))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector(("swipeResponse:")))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector(("swipeResponse:")))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    func swipeResponse(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            default:
                break
            }
        }
    }

    
    
    
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
