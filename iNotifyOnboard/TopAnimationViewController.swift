//
//  TopAnimationViewController.swift
//  iNotifyOnboard
//
//  Created by Shan on 2018/11/12.
//  Copyright © 2018 Shan. All rights reserved.
//

import UIKit

class TopAnimationViewController: UIViewController {
    
    enum SendingTextState: Int {
        case oneDot = 1
        case twoDot = 2
        case threeDot = 3
    }
    
    @IBOutlet weak var notificationBackgroundView: UIView!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var animationBackgroundView: UIView!
    
    var textAnimationTimer: Timer!
    var sendingTextState: SendingTextState! = .oneDot
    var notificationViewTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("deinit of TopAnimationViewController.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initView()
        setTextingAnimationTimer()
        setNotificationAnimationTimer()
    }
    
    private func initView() {
        
        notificationBackgroundView.layer.roundCorners(radius: 5)
        notificationBackgroundView.layer.addShadow()
    }
    
    private func setTextingAnimationTimer() {
        // use a timer to do texting offset animation.
        textAnimationTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(changeText), userInfo: nil, repeats: true)
    }
    
    @objc private func changeText() {
        let state = sendingTextState.rawValue
        switch state {
        case 1:
            stateLabel.text = "Sending."
            sendingTextState = .twoDot
        case 2:
            stateLabel.text = "Sending.."
            sendingTextState = .threeDot
        case 3:
            stateLabel.text = "Sending..."
            sendingTextState = .oneDot
        default:
            stateLabel.text = "Sending."
            sendingTextState = .twoDot
        }
    }
    
    @objc private func changeNotificationViewScale() {
        let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.notificationBackgroundView.transform = scale
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.notificationBackgroundView.transform = .identity
            })
        }
    }
    
    private func setNotificationAnimationTimer() {
        notificationViewTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(changeNotificationViewScale), userInfo: nil, repeats: true)
    }
}

extension CALayer {
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 0.3
        self.shadowRadius = 10
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    private func addShadowWithRoundedCorners() {
        if let content = self.contents {
            
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }.forEach{ $0.roundCorners(radius: self.cornerRadius) }
            
            self.contents = nil
            
            if let sublayer = sublayers?.first, sublayer.name == "effectLayer" {
                sublayer.removeFromSuperlayer()
            }
            
            let contentLayer = CALayer()
            contentLayer.name = "effectLayer"
            contentLayer.contents = content
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            
            insertSublayer(contentLayer, at: 0)
        }
    }
}












