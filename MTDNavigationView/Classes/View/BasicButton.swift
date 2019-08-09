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
        commonInitilization()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitilization()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width,
                      height: MTDNavigationManager.style.contentHeight)
    }
    
    func commonInitilization() {
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
            setTitleColor(color.withAlphaComponent(0.4), for: .highlighted)
            setTitleColor(color.withAlphaComponent(0.4), for: .disabled)
        }
    }
    
    public convenience init(title: String?, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .custom)
        setTitle(title, for: .normal)
        if let target = target, let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
}

open class BackButton: ImageButton {    
    public class func `default`() -> BackButton {
        return BackButton(image: Bundle.image(named: "nav_bar_back_ic"))
    }
    
    override func commonInitilization() {
        super.commonInitilization()
        self.contentEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 2 * CGFloat.defaultEdge,
                                              bottom: 0,
                                              right: CGFloat.defaultEdge)
    }
}

extension UIImage {
    func withAlpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


extension CGFloat {
    static let defaultEdge: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 10 : 8
}
