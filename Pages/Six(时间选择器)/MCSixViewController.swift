//
//  MCSixViewController.swift
//  MCAPI
//
//  Created by MC on 2018/8/13.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class MCSixViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        initUI()
        
        managerClosure()
        
        sendNetworking()
    }
    
    // MARK: - System Delegate
    
    // MARK: - Custom Delegate
    
    // MARK: - Closure
    func managerClosure() {
        pickerView.datePickerClosure = { time in
            self.showReseutLabel.text = "选中的时间是  " + time
        }
    }
    
    // MARK: - Action
    
    // MARK: - Network
    func sendNetworking() {

    }
    
    // MARK: - Method
    func baseSetting() {
        title = "时间选择器"
        view.backgroundColor = UIColor.white
    }
    
    func initUI() {
        view.addSubview(pickerView)
        pickerView.snp.remakeConstraints { (make) ->Void in
            make.top.equalTo(100)
            make.left.right.equalTo(view)
            make.height.equalTo(216)
        }
        
        view.addSubview(showReseutLabel)
        showReseutLabel.snp.remakeConstraints { (make) ->Void in
            make.centerX.equalTo(view)
            make.top.equalTo(pickerView.snp.bottom).offset(50)
        }
    }
    
    // MARK: - Setter & Getter
    lazy var pickerView: MCDatePicker = {
        let p = MCDatePicker()
        p.titleFont = 14
        p.titleColor = UIColor.red
    
//        p.minimumDate = MCDateManager_getDateFromString("2000-02-02")
//        p.defaultDate = MCDateManager_getDateFromString("2003-02-02")
//        p.maximumDate = MCDateManager_getDateFromString("2002-02-02")
//

        // ---------->   设置时间的显示模式   <-------------//
        p.settingPickerView(mode: MCDateMode.year_month_day)
        return p
    }()
    
    lazy var showReseutLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        return label
    }()
}
