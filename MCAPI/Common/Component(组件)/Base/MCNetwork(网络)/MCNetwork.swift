//
//  MCNetwork.swift
//  MCAPI
//
//  Created by MC on 2018/7/26.
//  Copyright © 2018年 MC. All rights reserved.
//

import Foundation
import Alamofire

class MCNetwork {
    //shared instance
    static let shared = MCNetwork()
    
    private let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    typealias RespnseClosure<T> = (MCNetworkStatus) -> Void
    func startNetworkReachabilityObserver(response:@escaping RespnseClosure<MCNetworkStatus>) {
        
        reachabilityManager?.listener = { status in
            switch status {
                
            case .notReachable:
                response(.notReachable)
            case .unknown :
                response(.unknown)

            case .reachable(.ethernetOrWiFi):
                response(.WIFI)

            case .reachable(.wwan):
                response(.WWAN)
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
    // 销毁
    deinit {
        reachabilityManager?.stopListening()
    }
}


enum MCNetworkStatus {
    case notReachable
    case unknown
    case WIFI
    case WWAN
}




















