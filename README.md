# MCAPI

###功能一： 定位与编码封装

![定位与编码/反编码](https://github.com/mancongiOS/MCAPI/blob/master/GitHubImages/location.png)
```

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

```

###功能二: 网络监听
![网络监听](https://github.com/mancongiOS/MCAPI/blob/master/GitHubImages/wifi.png)

```
MCNetwork.shared.startNetworkReachabilityObserver { (status) in

    switch status {
    case .WIFI:
        self.showStatusLabel.text = "网络状态：wifi"
    default:
        self.showStatusLabel.text = "网络状态：非wifi"
    }
}
```



###功能三: 自定义MJRefresh
![网络监听](https://github.com/mancongiOS/MCAPI/blob/master/GitHubImages/MJRefresh.png)
```
tableView.mj_header = MCRefreshHeader(refreshingBlock: {
}

tableView.mj_footer = MCRefreshFooter(refreshingBlock: {
}
```


###功能二: 倒计时
![网络监听](https://github.com/mancongiOS/MCAPI/blob/master/GitHubImages/countDown.png)
```
let time = countDown.openCountdown(start: "2016-12-07 10:00:00.0", end: "2016-12-07 10:00:10.0", format: "yyyy-MM-dd HH:mm:ss.S")

showCountDown(time: time)
countDown.closure = {time in
    print(time)
}
```

###功能二:自定义时间选择器
![网络监听](https://github.com/mancongiOS/MCAPI/blob/master/GitHubImages/datePicker.png)
```
lazy var pickerView: MCDatePicker = {
    let p = MCDatePicker()
    p.titleFont = 14
    p.titleColor = UIColor.red

    //        设置最大时间，设置最小时间，设置默认选中时间
    //        p.minimumDate = MCDateManager_getDateFromString("2000-02-02")
    //        p.defaultDate = MCDateManager_getDateFromString("2003-02-02")
    //        p.maximumDate = MCDateManager_getDateFromString("2002-02-02")
    //

    // ---------->   设置时间的显示模式 MCDateMode  <-------------//
    p.settingPickerView(mode: MCDateMode.year_month_day)
    return p
}()
```

