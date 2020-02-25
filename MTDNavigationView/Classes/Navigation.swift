//
//  Navigation.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/3.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

public final class Navigation<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol NavigationCompatible {
    associatedtype NavigationCompatibleType
    var mtd: NavigationCompatibleType { get }
}

public extension NavigationCompatible {
    var mtd: Navigation<Self> {
        return Navigation(self)
    }
}


public protocol NavigationViewCustomizable {
    var navigationView: NavigationView { get }
}
