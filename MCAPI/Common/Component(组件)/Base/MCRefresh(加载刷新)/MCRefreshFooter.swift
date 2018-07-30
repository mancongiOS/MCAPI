//
//  MCRefreshFooter.swift
//  MCAPI
//
//  Created by MC on 2018/7/27.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import MJRefresh

class MCRefreshFooter: MJRefreshBackFooter {

    /**
     * 重写父类prepare方法
     * 做一个初始化配置，比如添加子控件
     */
    override func prepare() {
        super.prepare()
        mj_h = 50
        self.addSubview(refreshStatusLabel)
        self.addSubview(refreshImageView)
    }
    
    
    override var state: MJRefreshState {
        
        didSet {
            switch state {
            case .idle:
                refreshImageView.isHidden = false
                self.stopAnimation()
                refreshStatusLabel.text = "准备加载"
            case .pulling:
                refreshImageView.isHidden = true
                refreshStatusLabel.text = "松开加载更多"
            case .refreshing:
                refreshImageView.isHidden = false
                self.startLoadingAnimation()
                refreshStatusLabel.text = "加载中..."
            case .noMoreData:
                refreshImageView.isHidden = true
                refreshStatusLabel.text = "暂无更多数据"
            default:
                break
            }
        }
    }
    
    
    /**
     * 在这里设置子控件的位置和尺寸
     */
    override func placeSubviews() {
        super.placeSubviews()
        
        refreshStatusLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        refreshImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        refreshImageView.center = CGPoint(x: refreshStatusLabel.frame.midX - 50, y: self.mj_h * 0.5)
    }
    
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    func  startLoadingAnimation() {
        let animainton : CABasicAnimation = CABasicAnimation()
        animainton.keyPath = "transform.rotation"
        animainton.duration = 1.0
        animainton.toValue = -Double.pi
        animainton.toValue = -Double.pi * 2
        animainton.repeatCount = MAXFLOAT
        refreshImageView.layer.add(animainton, forKey: "footerLoadingAnimation")
    }
    
    func stopAnimation() {
        refreshImageView.layer.removeAnimation(forKey: "footerLoadingAnimation")
    }
    
    
    
    //MARK: 懒加载
    lazy var refreshStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var refreshImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "Refresh_footer")
        return imageView
    }()
}
