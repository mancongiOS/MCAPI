//
//  MCTwoViewController.swift
//  MCAPI
//
//  Created by MC on 2018/7/26.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

/**
 * 网络监控(NetworkReachabilityManager)
 * https://www.jianshu.com/p/c3980b4c07c5
 */

class MCTwoViewController: UIViewController {

    @IBOutlet weak var showStatusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "网络监听"
        
        MCNetwork.shared.startNetworkReachabilityObserver { (status) in
            
            switch status {
            case .WIFI:
                self.showStatusLabel.text = "网络状态：wifi"
            default:
                self.showStatusLabel.text = "网络状态：非wifi"
            }
        }
    }
}
