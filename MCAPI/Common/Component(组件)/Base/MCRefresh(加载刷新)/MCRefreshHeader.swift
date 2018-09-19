//
//  MCRefreshHeader.swift
//  MCAPI
//
//  Created by MC on 2018/7/27.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import MJRefresh

class MCRefreshHeader: MJRefreshHeader {

    /**
     * 重写父类prepare方法
     * 做一个初始化配置，比如添加子控件
     */
    override func prepare() {
        super.prepare()
        
        // 设置高度
        mj_h = 120
        
        self.addSubview(refreshStatusLabel)
        self.addSubview(refreshImageView)
        
        refreshImageView.startAnimating()
    }

    
    /**
     * 在这里设置子控件的位置和尺寸
     */
    override func placeSubviews() {
        super.placeSubviews()
        self.refreshImageView.frame = CGRect.init(x: 0, y: 10, width: bounds.size.width, height: 60)
        refreshStatusLabel.frame = CGRect.init(x: 0, y: 80, width: frame.size.width, height: 30)
    }
    
    /**
     * 销毁的处理
     */
    deinit {
        // 停止动画
        refreshImageView.startAnimating()
    }

    /**
     * 监听scrollView的contentOffset改变
     */
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    /**
     * 监听scrollView的contentSize改变
     */
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }

    /**
     * 监听scrollView的拖拽状态改变
     */
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    
    override var state: MJRefreshState {
        
        didSet {
            switch state {
                
            case .idle:
                refreshStatusLabel.text = "准备加载"
                refreshImageView.startAnimating()
            case .willRefresh:
                refreshStatusLabel.text = "即将刷新"
            case .pulling:
                refreshStatusLabel.text = "松开刷新"
            case .refreshing:
                refreshStatusLabel.text = "正在刷新"
            default:
                break
            }
        }
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

        let image1 = UIImage.init(named: "Refresh_header_one")
        let image2 = UIImage.init(named: "Refresh_header_two")
        let image3 = UIImage.init(named: "Refresh_header_three")


        let array  = [image1,image2,image3]
        imageView.animationImages = array as? [UIImage]
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = Int.max
        
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
}
