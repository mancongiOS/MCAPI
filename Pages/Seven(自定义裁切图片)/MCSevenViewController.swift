//
//  MCSevenViewController.swift
//  MCAPI
//
//  Created by MC on 2018/9/14.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class MCSevenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        initUI()
    }
    
    // MARK: - Setter & Getter
    lazy var chooseButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.backgroundColor = UIColor.orange
        button.setTitle("选择图片", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(chooseButtonClicked), for: .touchUpInside)
        return button
    }()
    
    
    lazy var showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
}

//MARK: 通知回调，闭包回调，点击事件
extension MCSevenViewController {
    
    @objc func chooseButtonClicked() {
        let vc = MCClipImageViewController()
        
        vc.delegate = self
        /** 矩形框情况分析
         * 1. 裁切框的宽高比 > 0. 一切图片宽高比正常
         * 2. 裁切框的宽高比 = 1. 一切图片宽高比正常
         * 3. 裁切框吧宽高比 < 0. 都有问题
         */
        
        
        // 宽高比 分别为  > 0   = 0   < 0
        let image1 = #imageLiteral(resourceName: "Big_1")
        let image2 = #imageLiteral(resourceName: "Big_2")
        let image3 = #imageLiteral(resourceName: "Big_3")
        
        // 宽高比较小的图
        let image4 = #imageLiteral(resourceName: "Small_1")
        let image5 = #imageLiteral(resourceName: "Small_2")
        let image6 = #imageLiteral(resourceName: "Small_3")
        
        
        let image7 = #imageLiteral(resourceName: "CustomClipImage_1")
        let image8 = #imageLiteral(resourceName: "CustomClipImage_2")
        let image9 = #imageLiteral(resourceName: "CustomClipImage_3")
        
        
        
        
        // 宽高比 分别为  > 0   = 0   < 0
        let size1 = CGSize.init(width: self.view.bounds.size.width, height: self.view.bounds.size.width/2)
        let size2 = CGSize.init(width: self.view.bounds.size.width, height: self.view.bounds.size.width)
        let size3 = CGSize.init(width: self.view.bounds.size.width*0.6, height: self.view.bounds.size.width)

        
        let image = image9
        let size = size2
        
        vc.settingUIDataWithImage(image, size: size)
        self.present(vc, animated: true, completion: nil)
    }
}


//MARK: UI的处理,通知的接收
extension MCSevenViewController {
    
    func baseSetting() {
        self.title = "自定义裁切图片"
        view.backgroundColor = UIColor.white
    }
    
    
    func initUI() {

        
        
        showImageView.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        showImageView.center = CGPoint.init(x: view.center.x, y: 200)
        view.addSubview(showImageView)
        
        chooseButton.frame = CGRect.init(x: 0, y: 0, width: 300, height: 40)
        chooseButton.center = CGPoint.init(x: view.center.x, y: 500)
        view.addSubview(chooseButton)
    }
}


extension MCSevenViewController : MCClipImageViewControllerDelegate {
    func MCClipImageDidCancel() {
        print("点击了取消按钮")
    }
    
    func MCClipImageClipping(image: UIImage) {
        showImageView.image = image
    }
}
