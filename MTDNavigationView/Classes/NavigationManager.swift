//
//  NavigationManager.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/5.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

public protocol NavigationViewBuilderType {
    func backButton() -> UIControl
    func build() -> NavigationView
}

public final class DefaultNavigationViewBuilder: NavigationViewBuilderType {
    
    public func backButton() -> UIControl {
        return BackButton.default()
    }
    
    public func build() -> NavigationView {
        return NavigationView()
    }
}

public struct NavigationStyle {
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

public final class NavigationManager {
    public static var navigationViewBuilder: NavigationViewBuilderType = DefaultNavigationViewBuilder()
    public static var style: NavigationStyle = NavigationStyle()
    
    public class func backButton(with builder: NavigationViewBuilderType = NavigationManager.navigationViewBuilder) -> UIControl {
        return builder.backButton()
    }
    
    public class func build(with builder: NavigationViewBuilderType = NavigationManager.navigationViewBuilder) -> NavigationView {
        return builder.build()
    }
}
