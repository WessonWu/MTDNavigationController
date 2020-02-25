//
//  NavigationItemView.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/3.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

open class ImageItemView: ImageButton {}

open class TitleItemView: TitleButton {}

open class SpacingItemView: TransparentBackgroundView {
    open var spacing: CGFloat = 0
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: spacing, height: 1)
    }
    
    public convenience init(spacing: CGFloat) {
        self.init()
        self.spacing = spacing
    }
    
    override func commonInitilization() {
        super.commonInitilization()
        
        self.isUserInteractionEnabled = false
    }
}
