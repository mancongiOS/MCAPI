//
//  MCCountDown.swift
//  MCAPI
//
//  Created by MC on 2018/7/30.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

/**
 * 时间格式应用 https://www.cnblogs.com/mancong/p/5422471.html
 */

typealias MCCountDownClosure = (MCCountDownStruct) -> Void

class MCCountDown: NSObject {

    var closure : MCCountDownClosure?
    
    
    private var second = 0
    private var minit = 0
    private var hour = 0
    private var day = 0
    private var nanosecond = 0

    private var timer : Timer?
    
    
    func openCountdown(start:String,end:String,format:String) -> MCCountDownStruct {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.init(identifier: "GMT")
        
        let createDate = dateFormatter.date(from: start)
        let endDate = dateFormatter.date(from: end)
        
        
        let calendar = Calendar.current
        let unit:Set<Calendar.Component> = [.day,.hour,.minute,.second,.nanosecond]
        let commponent:DateComponents = calendar.dateComponents(unit, from: createDate!, to: endDate!)
        
        second      = commponent.second     ?? 0
        minit       = commponent.minute     ?? 0
        hour        = commponent.hour       ?? 0
        day         = commponent.day        ?? 0
        nanosecond  = commponent.nanosecond ?? 0
        
        let time = MCCountDownStruct(day:day,hour:hour,minit:minit,second:second,nanosecond:nanosecond)
        
        print("\(time)-----createDate\(createDate!) ---start\(start) ----- endDate\(endDate!)---end\(end)")
        
        
        
        //TODO: 为什么这个闭包为nil，没有回调出去！！！
        closure?(time)

        if  nanosecond == 0 && second == 0 && minit == 0 && hour == 0 && day == 0 {
            return time
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1/10, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        }
        
        return time
    }
    
    @objc func timerAction() {
        
        nanosecond = nanosecond - 1
        
        if nanosecond == -1 {
            nanosecond = 9
            
            second = second - 1
            
            if second == -1 {
                second = 59
                minit = minit - 1
                if minit == -1 {
                    minit = 59
                    hour = hour - 1
                    if hour == -1 {
                        hour = 23
                        day = day - 1
                    }
                }
            }

        }
        
        
        if  nanosecond == 0 && second == 0 && minit == 0 && hour == 0 && day == 0 {
            self.timer?.invalidate()
            timer = nil
        }
        let time = MCCountDownStruct(day:day,hour:hour,minit:minit,second:second,nanosecond:nanosecond)
        closure?(time)
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }
}


struct MCCountDownStruct {
    var day        : Int
    var hour       : Int
    var minit      : Int
    var second     : Int
    var nanosecond : Int
}
