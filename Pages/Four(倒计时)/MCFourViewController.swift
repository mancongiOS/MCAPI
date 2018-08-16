//
//  MCFourViewController.swift
//  MCAPI
//
//  Created by MC on 2018/7/30.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class MCFourViewController: UIViewController {

    @IBOutlet weak var showLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "倒计时"
        
        let time = countDown.openCountdown(start: "2016-12-07 10:00:00.0", end: "2016-12-07 10:00:10.0", format: "yyyy-MM-dd HH:mm:ss.S")
        showCountDown(time: time)
        
        countDown.closure = {time in
            
            self.showCountDown(time: time)
        }
    }
    
    func showCountDown(time:MCCountDownStruct) {
        self.showLabel.text = "天\(time.day)   小时\(time.hour)   分钟\(time.minit)   秒\(time.second)   毫秒\(time.nanosecond)"
    }
    
    lazy var countDown: MCCountDown = {
        let c = MCCountDown()
        return c
    }()
}
