//
//  FeaturesTableViewController.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/5.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import UIKit
import MTDNavigationView

class FeaturesTableViewController: UITableViewController {

    @IBOutlet weak var isTranslucentSwitch: UISwitch!
    @IBOutlet weak var isNavigationViewHiddenAnimatedSwitch: UISwitch!
    @IBOutlet weak var isNavigationSwitchHiddenSwitch: UISwitch!
    @IBOutlet weak var prefersStatusBarHiddenSwitch: UISwitch!
    @IBOutlet weak var disableInteractivePopSwitch: UISwitch!
    
    @IBOutlet weak var navigationViewBackgroundColorLabel: UILabel!
    
    var navigationViewBackgroundColor: ColorTuple? {
        didSet {
            if let color = navigationViewBackgroundColor?.color {
                self.mtd.navigationView.backgroundColor = color
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.extendedLayoutIncludesOpaqueBars = true
//        self.edgesForExtendedLayout.remove(.top)
        let mtd_self = self.mtd
        let navigationView = mtd_self.navigationView
        self.isTranslucentSwitch.isOn = navigationView.isTranslucent
        self.isNavigationSwitchHiddenSwitch.isOn = mtd_self.isNavigationViewHidden
        let imageItem = MTDImageItemView(image: #imageLiteral(resourceName: "nav_share_ic"), target: self, action: #selector(onShareItemClick(_:)))
        imageItem.isEnabled = false
        let titleItem = MTDTitleItemView(title: "完成", target: self, action: #selector(onShareItemClick(_:)))
        titleItem.isEnabled = false
        navigationView.leftNavigationItemViews = [imageItem, titleItem]
        navigationView.rightNavigationItemViews = [MTDImageItemView(image: #imageLiteral(resourceName: "nav_share_ic"), target: self, action: #selector(onShareItemClick(_:))),
                                                   MTDTitleItemView(title: "Present", target: self, action: #selector(presentNext))]
        navigationView.backButton.isHidden = false
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return prefersStatusBarHiddenSwitch?.isOn ?? false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "backgroundColorSelection" {
            if let vc = segue.destination as? ColorSelectionTableViewController {
                vc.selectionCallback = { [weak self] (color) in
                    self?.navigationViewBackgroundColor = color
                    self?.navigationViewBackgroundColorLabel.text = color.title
                }
            }
        }
    }
    
    
    @IBAction func onValueChanged(_ sender: UISwitch) {
        switch sender {
        case isTranslucentSwitch:
            self.mtd.navigationView.isTranslucent = sender.isOn
        case isNavigationSwitchHiddenSwitch:
            self.mtd.setNavigationViewHidden(sender.isOn,
                                             animated: isNavigationViewHiddenAnimatedSwitch.isOn)
        case prefersStatusBarHiddenSwitch:
            self.setNeedsStatusBarAppearanceUpdate()
        case disableInteractivePopSwitch:
            self.mtd.disableInteractivePop = sender.isOn
        default:
            break
        }
    }
    
    
    @IBAction func onShareItemClick(_ sender: Any) {
        self.title = "Features" + arc4random_uniform(100).description
    }
    
    @IBAction func presentNext() {
        let sb = UIStoryboard(name: "Features", bundle: Bundle.main)
        guard let vc = sb.instantiateInitialViewController() else {
            return
        }
        
        self.mtd.present(vc, animated: true)
    }
}
