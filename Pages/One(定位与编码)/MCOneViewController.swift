//
//  MCOneViewController.swift
//  MCAPI
//
//  Created by MC on 2018/7/26.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit


/**
 Error Domain=kCLErrorDomain Code=2 “The operation couldn’t be completed. (kCLErrorDomain error 2.)”
 
 网络错误,CLGeocoder需要一个网络连接,不应该每分钟发送多个地理编码请求.geocoder断绝希望保护自己免受被请求从一个设备过载。你只是必须限制你发送的请求数
 
 解决方法：
 
 1.确定模拟器（手机）已经联网并且允许程序获取地理位置
 
 2.重置地理位置服务或者网络服务
 
 3.等一会，大改两个小时左右
 
 PS：如果是模拟器就果断直接重置模拟器吧  IOS Simulator - Reset Content and Settings..。
 */

class MCOneViewController: UIViewController {

    @IBOutlet weak var oneLabel: UILabel!
    
    @IBOutlet weak var twoLabel: UILabel!
    
    @IBOutlet weak var threeLabel: UILabel!
    
    private var notificationName = NSNotification.Name(rawValue: NSNotification.Name.UIApplicationDidBecomeActive.rawValue)
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "定位和编码"
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: notificationName, object: nil)

        startLocation()

    }
    
    func startLocation() {
        weak var weakSelf = self
        
        // 一定不要写在懒加载中，不然只能定位一次
        positioning.startPositioning(self)
        positioning.clousre = { (latitude,longitude) in
            
            let oneStr = "定位的纬度: \(latitude)  ----经度: \(longitude)"
            self.oneLabel.text = oneStr
            
            weakSelf!.geccoder.MCeverseGeocode(latitude: latitude, longitude: longitude, success: { (addressInfo) in
               
                let twoStr = "反编码出来的地址：" + addressInfo.addressLines
                self.twoLabel.text = twoStr
                
                
                weakSelf!.geccoder.MCLocationEncode(address: addressInfo.addressLines, success: { (coor) in
                   
                    let threeStr = "根据地址编码出来的经纬度: \(coor.latitude)----\(coor.longitude)"
                    self.threeLabel.text = threeStr
                },failure: {(error) in
                    self.threeLabel.text = error
                })
                
            }, failure: { (error) in
                self.twoLabel.text = error
            })
        }
    }
    
    @objc func didBecomeActive() {
        startLocation()
    }

    
    
    // 使用的时候一定要声明成为持久变量，否则会提前销毁，不执行couslre
    lazy var positioning: MCPositioning = {
        let p = MCPositioning()
        return p
    }()
    
    // 使用的时候一定要声明成为持久变量，否则会提前销毁，不执行couslre
    lazy var geccoder: MCGeocoder = {
        let g = MCGeocoder()
        return g
    }()

}
