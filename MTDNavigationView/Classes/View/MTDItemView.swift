//
//  MTDNavigationItemView.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/3.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

open class MTDImageItemView: ImageButton {}

open class MTDTitleItemView: TitleButton {}

open class MTDSpacingItemView: NoBackgroundView {
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
