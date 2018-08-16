# MCAPI

###功能一： 定位与编码封装
![定位与编码/反编码](https://github.com/mancongiOS/MCAPI/blob/master/GitHubImages/location.png)
```
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
```
