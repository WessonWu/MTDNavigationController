//
//  MTDNavigation+UIViewController.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/3.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

internal struct AssociatedKeys {
    static var navigationView = "mtd_navigationView"
    static var disableInteractivePop = "mtd_disableInteractivePop"
    static var adjustedContentInsetTop = "mtd_adjustedContentInsetTop"
    static var adjustedSafeAreaInsetTop = "mtd_adjustedSafeAreaInsetTop"
}

extension UIViewController: NavigationCompatible {}

public extension Navigation where Base: UIViewController {
    var navigationController: NavigationController? {
        var vc: UIViewController = self.base
        while !vc.isKind(of: NavigationController.self) {
            guard let navigationController = vc.navigationController else {
                return nil
            }
            vc = navigationController
        }
        return vc as? NavigationController
    }
    
    var wrapper: NavigationWrapperController? {
        return self.base.parent as? NavigationWrapperController
    }
    
    func safeWrap() -> UIViewController {
        return MTDSafeWrapViewController(base)
    }
    
    func safeUnwrap() -> UIViewController {
        return MTDSafeUnwrapViewController(base)
    }
    
    var navigationView: NavigationView {
        if let view = objc_getAssociatedObject(base, &AssociatedKeys.navigationView) as? NavigationView {
            return view
        }
        if let customizable = base as? NavigationViewCustomizable {
            let view = customizable.navigationView
            if view.owning == nil {
                view.owning = base
            }
            objc_setAssociatedObject(base, &AssociatedKeys.navigationView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        let view = NavigationManager.build()
        view.owning = base
        objc_setAssociatedObject(base, &AssociatedKeys.navigationView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return view
    }
    
    var disableInteractivePop: Bool {
        get {
            return disableInteractivePopAssociatedObject?.boolValue ?? false
        }
        
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.disableInteractivePop, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var isNavigationViewHidden: Bool {
        return navigationView.isNavigationViewHidden
    }
    
    func setNavigationViewHidden(_ hidden: Bool, animated: Bool) {
        wrapper?.setNavigationViewHidden(hidden, animated: animated)
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        let mtd_vc = viewControllerToPresent.mtd
        let wrapped = mtd_vc.safeWrap()
        let navigationView = mtd_vc.navigationView
        if navigationView.delegate == nil {
            navigationView.delegate = wrapped as? NavigationWrapperController
        }
        base.present(wrapped, animated: flag, completion: completion)
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let vc = base.parent as? NavigationWrapperController {
            vc.dismiss(animated: flag, completion: completion)
        } else {
            base.dismiss(animated: flag, completion: completion)
        }
    }
}

internal extension Navigation where Base: UIViewController {
    var disableInteractivePopAssociatedObject: NSNumber? {
        return objc_getAssociatedObject(base, &AssociatedKeys.disableInteractivePop) as? NSNumber
    }
    
    var hasSetInteractivePop: Bool {
        return disableInteractivePopAssociatedObject != nil
    }
}
