//
//  MTDNavigation.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/3.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

public final class MTDNavigation<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol MTDNavigationCompatible {
    associatedtype MTDNavigationCompatibleType
    var mtd: MTDNavigationCompatibleType { get }
}

public extension MTDNavigationCompatible {
    var mtd: MTDNavigation<Self> {
        return MTDNavigation(self)
    }
}


public protocol MTDNavigationViewCustomizable {
    var navigationView: MTDNavigationView { get }
}
