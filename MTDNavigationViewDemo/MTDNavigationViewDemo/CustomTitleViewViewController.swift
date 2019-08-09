//
//  CustomTitleViewViewController.swift
//  MTDNavigationViewDemo
//
//  Created by wuweixin on 2019/8/8.
//  Copyright © 2019 wuweixin. All rights reserved.
//

import MTDNavigationView

class CustomTitleViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let mtd_vc = self.mtd
        let navigationView = mtd_vc.navigationView
        
        let titleView = UIButton(type: .contactAdd)
        navigationView.titleView = titleView
        // 不显示返回按钮
        navigationView.automaticallyAdjustsBackItemHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
