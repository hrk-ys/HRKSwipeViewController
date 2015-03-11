//
//  HRKSwipeViewController.swift
//  HRKSwipeViewController
//
//  Created by Hiroki Yoshifuji on 2015/03/11.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import UIKit

enum HRKSwipeViewControllerTopViewPosition:Int {
   case Center = 0
   case Left = 1
   case Right = 2
}

class HRKSwipeViewController : UIViewController {
    
    private var currentTopViewPosition:HRKSwipeViewControllerTopViewPosition = .Center
    
    var topViewController: UIViewController?
    var leftViewController: UIViewController?
    var rightViewController: UIViewController?
    
    override func awakeFromNib() {
        if let storyboard = self.storyboard {
            self.setTopViewController(storyboard.instantiateViewControllerWithIdentifier("TopNaviController") as UIViewController)
            self.setLeftViewController(storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as UIViewController)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vc = topViewController {
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
        }
    }
    
    private func removeVc(vc: UIViewController) {
        vc.view.removeFromSuperview()
        vc.willMoveToParentViewController(nil)
        vc.beginAppearanceTransition(false, animated: false)
        vc.removeFromParentViewController()
        vc.endAppearanceTransition()
    }
    
    func setTopViewController(vc: UIViewController) {
        if let oldVc = topViewController { removeVc(oldVc) }
    
        topViewController = vc
    
        if let vc = topViewController {
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
    
            if self.isViewLoaded() {
                vc.beginAppearanceTransition(true, animated:true)
                self.view.addSubview(vc.view)
                vc.endAppearanceTransition()
            }
        }
    }
    
    func setLeftViewController(vc: UIViewController) {
        if let oldVc = topViewController { removeVc(oldVc) }
    
        leftViewController = vc
    
        if leftViewController != nil {
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
        }
    }
    
    func setRightViewController(vc: UIViewController) {
        if let oldVc = topViewController { removeVc(oldVc) }
        
        rightViewController = vc
        
        if leftViewController != nil {
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
        }
    }
}
