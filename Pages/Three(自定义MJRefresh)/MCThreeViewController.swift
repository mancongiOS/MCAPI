//
//  MCThreeViewController.swift
//  MCAPI
//
//  Created by MC on 2018/7/26.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import SnapKit

class MCThreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        initUI()
        
        sendNetworking()
    }
    
    // MARK: - Network
    func sendNetworking() {
        for i in 0..<10 {
            dataArrayM.add("这是第\(i)组")
        }
    }
    
    // MARK: - Method
    func baseSetting() {
        self.title = "自定义MjRefresh"
    }
    
    func initUI() {

        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
        
        
        // 下拉刷新
        tableView.mj_header = MCRefreshHeader(refreshingBlock: {
            // 重置没有数据的设置
            self.tableView.mj_footer.resetNoMoreData()
            
            // 刷新数据源 （只保留前10条）
            self.dataArrayM.removeAllObjects()
            for i in 0..<10 {
                self.dataArrayM.add("这是第\(i)组")
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
            })
        })
        
        
        // 上拉加载
        tableView.mj_footer = MCRefreshFooter(refreshingBlock: {
            // 添加数据源
            let count = self.dataArrayM.count
            for i in count ..< count+10 {
                // 没有更多数据的处理
                if i == 30 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
                self.dataArrayM.add("这是第\(i)组")
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
            })
        })

    }
    
    // MARK: - Setter & Getter
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
 
        tableView.backgroundColor = UIColor.yellow
        return tableView
    }()

    lazy var dataArrayM: NSMutableArray = {
        let arrayM = NSMutableArray()
        return arrayM
    }()
}


extension MCThreeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrayM.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = dataArrayM[indexPath.row] as? String ?? ""
        
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.frame = CGRect.init(x: 0, y: 59, width: self.view.frame.size.width, height: 1)
        cell.contentView.addSubview(lineView)
        return cell
    }
}

