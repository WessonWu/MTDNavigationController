//
//  UIScrollView+Insets.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/5.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit

extension UIScrollView {
    var hasSetAdjustedContentInsetTop: Bool {
        return objc_getAssociatedObject(self, &AssociatedKeys.adjustedContentInsetTop) as? NSNumber != nil
    }
    // iOS 11.0 以下
    var adjustedContentInsetTop: CGFloat {
        get {
            if let number = objc_getAssociatedObject(self, &AssociatedKeys.adjustedContentInsetTop) as? NSNumber {
                return CGFloat(number.floatValue)
            }
            return 0
        }
        set {
            let originInsetTop = self.adjustedContentInsetTop
            guard originInsetTop != newValue else {
                return
            }
            
            let hasSetAdjustedContentInsetTop = self.hasSetAdjustedContentInsetTop
            
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
    var adjustedSafeAreaInsetTop: CGFloat {
        get {
            if let number = objc_getAssociatedObject(self, &AssociatedKeys.adjustedSafeAreaInsetTop) as? NSNumber {
                return CGFloat(number.floatValue)
            }
            return 0
        }
        set {
            let originInsetTop = self.adjustedSafeAreaInsetTop
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
    
    func adjustsScrollViewInsets(top: CGFloat) {
        self.view.adjustedScrollViewInsets(in: self.view, topInset: top)
    }
}

fileprivate extension UIView {
    @discardableResult
    func adjustedScrollViewInsets(in root: UIView, topInset: CGFloat) -> Bool {
        let edge = self.convert(self.bounds, to: root).minY - root.bounds.minY
        let inset = topInset - edge
        if let scrollView = self as? UIScrollView {
            scrollView.adjustedContentInsetTop = max(0, inset)
            return true
        }
        
        guard inset > 0 else {
            return false
        }
        
        for subview in subviews {
            if subview.adjustedScrollViewInsets(in: self, topInset: inset) {
                return true
            }
        }
        
        return false
    }
}

