//
//  MCGeocoder.swift
//  MCAPI
//
//  Created by MC on 2018/7/26.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import CoreLocation

class MCGeocoder: NSObject {


    typealias MCeverseSuccess<T> = (MCAddressInfo) -> ()
    typealias MCeverseFailure = (String) -> ()
    
    
    
    /**
     * 根据经纬度反编码地理位置信息
     */
    func MCeverseGeocode(latitude:Double,longitude:Double,success: @escaping MCeverseSuccess<MCAddressInfo>, failure: MCeverseFailure? = nil) {
        
        // 针对传入的经纬度进行校验
        if isInvalidRegion(latitude: latitude, longitude: longitude) {
           
            if failure != nil {
                failure!("经纬度超出范围")
            }
            return
        }
        
        let geocoder = CLGeocoder.init()
        let currentLocation = CLLocation.init(latitude: latitude, longitude: longitude)

        print("\(latitude)  ---   \(longitude)  -----  \(currentLocation)")
        
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in

            if error != nil {
                if failure != nil {
                    failure!(error?.localizedDescription ?? "")
                }
                return
            }
            
            if let place = placemarks?[0]{
                
                // 国家 省  市  区  街道  名称  国家编码  邮编   全地址
                let country = place.country ?? ""
                let administrativeArea = place.administrativeArea ?? ""
                let locality = place.locality ?? ""
                let subLocality = place.subLocality ?? ""
                let thoroughfare = place.thoroughfare ?? ""
                let name = place.name ?? ""
               
                let addressLines = country + administrativeArea + locality + subLocality + name
                
                
                let isoCountryCode = place.isoCountryCode ?? ""
                let postalCode = place.postalCode ?? ""

                let info = MCAddressInfo.init(country: country, province: administrativeArea, city: locality, area: subLocality, street: thoroughfare, name: name, addressLines: addressLines, countryCode: isoCountryCode, postalCode: postalCode)
                success(info)
            } else {
                
                if failure != nil {
                    failure!("No placemarks!")
                }
            }
        }
    }
    
    
    typealias MCLocationSuccess<T> = (MCCoordinate) -> ()
    typealias MCLocationFailure = (String) -> ()
    
    
    /**
     * 通过地址获取经纬度
     */
    func MCLocationEncode( address:String,success: @escaping MCLocationSuccess<MCCoordinate>, failure: MCLocationFailure? = nil) {
      
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            
            if error != nil {
                if failure != nil {
                    failure!(error?.localizedDescription ?? "")
                }
                return
            }
            
            if let place = placemarks?[0] {
                let latitude = place.location!.coordinate.latitude
                let longitude = place.location!.coordinate.longitude
                let coor = MCCoordinate.init(latitude: latitude, longitude: longitude)
                success(coor)
            } else {
                if failure != nil {
                    failure!("No placemarks!")
                }
            }
        })
    }
    
    
    
    /**
     * 判断经纬度代表的地区是否无效区域
     */
    func isInvalidRegion(latitude:Double,longitude:Double) -> Bool {
        //纬度的范围 -90 <= latitude <= 90   经度的范围是 -180 <= longitude <= 180
        if ((latitude < -90) && (latitude > 90)) { return true }
        if ((longitude < -180) && (longitude > 180)) { return true }
        return false
    }
    
}


struct MCCoordinate {
    var latitude  : Double
    var longitude : Double
}




struct MCAddressInfo {
    /**
     * 国家
     */
    var country       : String
    
    
    /**
     * 省
     */
    var province      : String
    
    
    /**
     * 城市
     */
    var city          : String
    
    
    /**
     * 区
     */
    var area          : String
    
    
    /**
     * 街道
     */
    var street        : String
    
    
    /**
     * 地名
     */
    var name          : String
    
    
    /**
     * 全地址信息
     */
    var addressLines  : String
    
    
    /**
     * 国家编码
     */
    var countryCode   : String
    
    
    /**
     * 邮政编码
     */
    var postalCode    : String
}


