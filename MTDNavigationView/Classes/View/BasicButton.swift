//
//  BasicButton.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/5.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

open class BasicButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width,
                      height: MTDNavigationManager.style.contentHeight)
    }
    
    func commonInit() {
        self.tintColor = MTDNavigationManager.style.tintColor
        self.contentEdgeInsets = UIEdgeInsets(top: 0,
                                              left: CGFloat.defaultEdge,
                                              bottom: 0,
                                              right: CGFloat.defaultEdge)
    }
}

open class ImageButton: BasicButton {
    public convenience init(image: UIImage?, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        setImage(image, for: .normal)
        if let target = target, let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    open override var titleLabel: UILabel? {
        return nil
    }
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        // do nothing
    }
    
    open override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        // do nothing
    }
    
    open override func setTitleShadowColor(_ color: UIColor?, for state: UIControl.State) {
        // do nothing
    }
    
    open override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        // do nothing
    }
}

open class TitleButton: BasicButton {
    open override var tintColor: UIColor! {
        get {
            return super.tintColor
        }
        set {
            super.tintColor = newValue
            let color = newValue ?? MTDNavigationManager.style.tintColor
            setTitleColor(color, for: .normal)
            setTitleColor(color.withAlphaComponent(0.4), for: .disabled)
        }
    }
    
    public convenience init(title: String?, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        if let target = target, let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        self.titleLabel?.font = MTDNavigationManager.style.textFont
    }
    
    open override var imageView: UIImageView? {
        return nil
    }
    
    open override func setImage(_ image: UIImage?, for state: UIControl.State) {
        // do nothing
    }
}

open class BackButton: ImageButton {    
    public class func `default`() -> BackButton {
        return BackButton(image: Bundle.mtd_image(named: "nav_bar_back_ic"))
    }
    
    override func commonInit() {
        super.commonInit()
        self.contentEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 2 * CGFloat.defaultEdge,
                                              bottom: 0,
                                              right: CGFloat.defaultEdge)
    }
}

extension CGFloat {
    static let defaultEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 10 : 8
}
