//
//  MCDatePickerPopupView.swift
//  MCAPI
//
//  Created by MC on 2018/8/30.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class MCDatePickerPopupView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(cancelButtonClicked))
        self.addGestureRecognizer(tap)
        
        self.addSubview(bgView)
        bgView.addSubview(pickerView)
        bgView.addSubview(cancelButton)
        bgView.addSubview(sureButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.frame = CGRect.init(x: 0, y: self.bounds.size.height - 256, width: self.bounds.size.width, height: 256)
        pickerView.frame = CGRect.init(x: 0, y: 40, width: self.bounds.size.width, height: 216)
        cancelButton.frame = CGRect.init(x: 10, y: 7, width: 60, height: 26)
        sureButton.frame = CGRect.init(x: self.bounds.size.width - 70, y: 7, width: 60, height: 26)
        

    }
    
    @objc func cancelButtonClicked() {
        self.removeFromSuperview()
    }
    
    @objc func sureButtonClicked() {
        self.removeFromSuperview()
    }
    
    @objc func emptyEvent() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(emptyEvent))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    public lazy var pickerView: MCDatePicker = {
        let p = MCDatePicker()
        
        //        p.minimumDate = MCDateManager_getDateFromString("2000-02-02")
        //        p.defaultDate = MCDateManager_getDateFromString("2003-02-02")
        //        p.maximumDate = MCDateManager_getDateFromString("2002-02-02")
        //
//        p.pickerView.showsSelectionIndicator = true

        // ---------->   设置时间的显示模式   <-------------//
        p.settingPickerView(mode: MCDateMode.year_month_day)
        return p
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.blue
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.alpha = 0.8
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var sureButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.blue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        return button
    }()
}
