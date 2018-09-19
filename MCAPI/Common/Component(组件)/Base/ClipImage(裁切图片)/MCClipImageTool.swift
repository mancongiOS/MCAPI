//
//  MCClipImageTool.swift
//  MCAPI
//
//  Created by MC on 2018/9/18.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

extension UIImage {
    
    
}

func rotationImage(image:UIImage,orientation:UIImageOrientation) -> UIImage {
    
    var rotate : Double = 0.0;
    var rect = CGRect.init()
    var translateX : CGFloat = 0.0;
    var translateY : CGFloat = 0.0;
    var scaleX : CGFloat = 1.0;
    var scaleY : CGFloat = 1.0;
    
    switch (orientation) {
    case .left:
        rotate = Double.pi / 2;
        rect = CGRect.init(x: 0, y: 0, width: image.size.height, height: image.size.width)
        translateX = 0
        translateY = -rect.size.width;
        scaleY = rect.size.width/rect.size.height;
        scaleX = rect.size.height/rect.size.width;
        break;
    case .right:
        rotate = 33 * Double.pi / 2;
        rect = CGRect.init(x: 0, y: 0, width: image.size.height, height: image.size.width)
        translateX = -rect.size.height;
        translateY = 0;
        scaleY = rect.size.width/rect.size.height;
        scaleX = rect.size.height/rect.size.width;
        break;
    case .down:
        rotate = Double.pi
        rect = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        translateX = -rect.size.width;
        translateY = -rect.size.height;
        break;
    default:
        rotate = 0.0;
        rect = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        translateX = 0;
        translateY = 0;
        break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext();
    //做CTM变换
    context?.translateBy(x: 0, y: rect.size.height)
    context?.scaleBy(x: 1, y: -1)
    context?.rotate(by: CGFloat(rotate))
    context?.translateBy(x: translateX, y: translateY)

    context?.scaleBy(x: scaleX, y: scaleY)
    
    context?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
    
    //绘制图片
    
    let newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic!
    
}



//
//func imageEdit(srcImage:UIImage,angle:Int) -> UIImage {
//    //原始图片
//    //翻转图片的方向
//
//
//
//////    //翻转图片
////    let flipImage = UIImage.init(cgImage: srcImage.cgImage!, scale: srcImage.scale, orientation: UIImageOrientation.init(rawValue: angle)!)
////
////    return flipImage
//    //Quartz重绘图片
//    let rect = CGRect.init(x: 0, y: 0, width: srcImage.size.width, height: srcImage.size.height)
//    //根据size大小创建一个基于位图的图形上下文
//    UIGraphicsBeginImageContextWithOptions(rect.size, false, 2)
//    let currentContext =  UIGraphicsGetCurrentContext();//获取当前quartz 2d绘图环境
//
//    //设置当前绘图环境到矩形框
//    currentContext?.clip(to: rect)
//     //旋转90度
//    currentContext?.rotate(by: CGFloat.pi)
//    //平移， 这里是平移坐标系，跟平移图形是一个道理
//    currentContext?.translateBy(x: -rect.size.width, y: -rect.size.height)
//
//    currentContext?.draw(srcImage.cgImage!, in: rect)
//
//
//    //翻转图片
//    let drawImage =  UIGraphicsGetImageFromCurrentImageContext();//获得图片
//
//    let flipImage = UIImage.init(cgImage: (drawImage?.cgImage!)!, scale: srcImage.scale, orientation: UIImageOrientation.left)
//
//    return flipImage
//
//}
