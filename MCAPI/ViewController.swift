//
//  ViewController.swift
//  MCAPI
//
//  Created by MC on 2018/7/25.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController {

    
    var dataArray : NSArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        initUI()
        
        sendNetworking()
    }
    
    // MARK: - System Delegate
    
    // MARK: - Custom Delegate
    
    // MARK: - Action
    
    // MARK: - Network
    func sendNetworking() {
        dataArray = [
            "定位与编码/反编码",
            "网络状态的监听",
            "自定义MJRefresh",
            "倒计时"
        ]
    }
    
    // MARK: - Method
    func baseSetting() {
    }
    
    func initUI() {
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
    
    // MARK: - Setter & Getter
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.white
        
        cell.textLabel?.text = dataArray?[indexPath.row] as? String ?? ""
        
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.frame = CGRect.init(x: 0, y: 59, width: self.view.frame.size.width, height: 1)
        cell.contentView.addSubview(lineView)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = MCOneViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = MCTwoViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = MCThreeViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = MCFourViewController()
            navigationController?.pushViewController(vc, animated: true)

        default:
            break
        }
    }
}


