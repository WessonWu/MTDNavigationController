//
//  MTDNavigationManager.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/5.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

public protocol MTDNavigationViewBuilderType {
    func backButton() -> UIControl
    func build() -> MTDNavigationView
}

public final class MTDNavigationViewDefaultBuilder: MTDNavigationViewBuilderType {
    
    public func backButton() -> UIControl {
        return BackButton.default()
    }
    
    public func build() -> MTDNavigationView {
        return MTDNavigationView()
    }
}

public struct MTDNavigationStyle {
    // basic attributes
    public var backgroundColor: UIColor = UIColor.white
    public var shadowImage: UIImage? = nil
    public var contentHeight: CGFloat = 44
    
    // Title Attributes
    public var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 17)
    public var titleColor: UIColor = UIColor.black
    
    // ItemView tintColor
    public var tintColor: UIColor = UIColor.black
    public var textFont: UIFont = UIFont.systemFont(ofSize: 16)
    
    public init() {}
}

public final class MTDNavigationManager {
    public static var navigationViewBuilder: MTDNavigationViewBuilderType = MTDNavigationViewDefaultBuilder()
    public static var style: MTDNavigationStyle = MTDNavigationStyle()
    
    public class func backButton(with builder: MTDNavigationViewBuilderType = MTDNavigationManager.navigationViewBuilder) -> UIControl {
        return builder.backButton()
    }
    
    public class func build(with builder: MTDNavigationViewBuilderType = MTDNavigationManager.navigationViewBuilder) -> MTDNavigationView {
        return builder.build()
    }
}
