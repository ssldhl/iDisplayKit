//
//  WindowWithStatusBarUnderlay.swift
//  iDisplaykit
//
//  Created by Sushil Dahal on 5/6/16.
//  Copyright © 2016 TechGuthi. All rights reserved.
//

import UIKit

// this subclass is neccessary to make the status bar have an opaque, colored background
class WindowWithStatusBarUnderlay: UIWindow {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let statusBarOpaqueUnderlayView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        statusBarOpaqueUnderlayView.backgroundColor = UIColor.darkBlueColor()
        addSubview(statusBarOpaqueUnderlayView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bringSubviewToFront(statusBarOpaqueUnderlayView)
        
        var statusBarFrame: CGRect = CGRectZero
        statusBarFrame.size.width = UIScreen.mainScreen().bounds.size.width
        statusBarFrame.size.height = UIApplication.sharedApplication().statusBarFrame.size.height
        statusBarOpaqueUnderlayView.frame = statusBarFrame
    }

}
