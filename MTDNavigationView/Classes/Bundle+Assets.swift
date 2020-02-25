//
//  Bundle+Assets.swift
//  MTDNavigationView
//
//  Created by wuweixin on 2019/8/7.
//

import UIKit

extension Bundle {
    static let mtd_assets: Bundle? = {
        let bundle = Bundle(for: MTDNavigationView.self)
        let path = "\(bundle.bundlePath)/MTDNavigationView_Xcassets.bundle"
        return Bundle(path: path)
    }()
    
    class func mtd_image(named: String, in bundle: Bundle? = mtd_assets, compatibleWith traitCollection: UITraitCollection? = nil) -> UIImage? {
        return UIImage(named: named, in: bundle, compatibleWith: traitCollection)
    }
}
