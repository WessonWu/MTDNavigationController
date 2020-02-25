//
//  UIScrollView+Insets.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/5.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

extension UIScrollView {
    var mtd_hasSetAdjustedContentInsetTop: Bool {
        return objc_getAssociatedObject(self, &AssociatedKeys.adjustedContentInsetTop) as? NSNumber != nil
    }
    // iOS 11.0 以下
    var mtd_adjustedContentInsetTop: CGFloat {
        get {
            if let number = objc_getAssociatedObject(self, &AssociatedKeys.adjustedContentInsetTop) as? NSNumber {
                return CGFloat(number.floatValue)
            }
            return 0
        }
        set {
            let originInsetTop = self.mtd_adjustedContentInsetTop
            guard originInsetTop != newValue else {
                return
            }
            
            let hasSetAdjustedContentInsetTop = self.mtd_hasSetAdjustedContentInsetTop
            
            var contentInsetTop = self.contentInset.top
            contentInsetTop -= originInsetTop
            contentInsetTop += newValue
            
            var scrollIndicatorInsetTop = self.scrollIndicatorInsets.top
            scrollIndicatorInsetTop -= originInsetTop
            scrollIndicatorInsetTop += newValue
            
            objc_setAssociatedObject(self, &AssociatedKeys.adjustedContentInsetTop, NSNumber(value: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.contentInset.top = contentInsetTop
            self.scrollIndicatorInsets.top = scrollIndicatorInsetTop
            
            if !hasSetAdjustedContentInsetTop {
                self.contentOffset.y = -contentInsetTop
            }
        }
    }
}

extension UIViewController {   
    @available(iOS 11.0, *)
    var mtd_adjustedSafeAreaInsetTop: CGFloat {
        get {
            if let number = objc_getAssociatedObject(self, &AssociatedKeys.adjustedSafeAreaInsetTop) as? NSNumber {
                return CGFloat(number.floatValue)
            }
            return 0
        }
        set {
            let originInsetTop = self.mtd_adjustedSafeAreaInsetTop
            guard originInsetTop != newValue else {
                return
            }
            
            var insetTop = self.additionalSafeAreaInsets.top
            insetTop -= originInsetTop
            insetTop += newValue
            
            objc_setAssociatedObject(self, &AssociatedKeys.adjustedSafeAreaInsetTop, NSNumber(value: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.additionalSafeAreaInsets.top = insetTop
        }
    }
    
    func mtd_adjustsScrollViewInsets(top: CGFloat) {
        self.view.mtd_adjustedScrollViewInsets(in: self.view, topInset: top)
    }
}

fileprivate extension UIView {
    @discardableResult
    func mtd_adjustedScrollViewInsets(in root: UIView, topInset: CGFloat) -> Bool {
        let edge = self.convert(self.bounds, to: root).minY - root.bounds.minY
        let inset = topInset - edge
        if let scrollView = self as? UIScrollView {
            scrollView.mtd_adjustedContentInsetTop = max(0, inset)
            return true
        }
        
        guard inset > 0 else {
            return false
        }
        
        for subview in subviews {
            if subview.mtd_adjustedScrollViewInsets(in: self, topInset: inset) {
                return true
            }
        }
        
        return false
    }
}

