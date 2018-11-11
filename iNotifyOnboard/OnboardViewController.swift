//
//  ViewController.swift
//  iNotifyOnboard
//
//  Created by Shan on 2018/11/11.
//  Copyright © 2018 Shan. All rights reserved.
//

import UIKit

class OnboardViewController: UIViewController {

    @IBOutlet weak var topViewContainer: UIView!
    private var topAnimationViewController: TopAnimationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    private func initView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        topAnimationViewController = (storyboard.instantiateViewController(withIdentifier: "TopAnimationViewController") as! TopAnimationViewController)
        addChild(topAnimationViewController)
        topAnimationViewController.didMove(toParent: self)
        view.addSubview(topAnimationViewController.view)
        
        // set constraints.
        let backgroundContainerView = topAnimationViewController.view
        let targetWidth = view.frame.width * 0.6
        let targetTopOffset = view.frame.height * 0.1
        backgroundContainerView?.translatesAutoresizingMaskIntoConstraints = false
        backgroundContainerView?.widthAnchor.constraint(equalToConstant: targetWidth).isActive = true
        backgroundContainerView?.heightAnchor.constraint(equalToConstant: targetWidth).isActive = true
        backgroundContainerView?.topAnchor.constraint(equalTo: view.topAnchor, constant: targetTopOffset).isActive = true
        backgroundContainerView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // set round corner.
        backgroundContainerView?.clipsToBounds = true
        backgroundContainerView?.layer.cornerRadius = targetWidth / 2
    }

}

