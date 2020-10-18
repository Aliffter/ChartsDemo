//
//  ViewController.swift
//  ChartsTest
//
//  Created by 赵隆晓 on 2020/10/12.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

import UIKit
import Charts
class ViewController: UIViewController {
    lazy var  tableView : UITableView = {
        let tableView = UITableView.init()

        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var dataSource: [String] = {
        let dataSource = ["测试","Charts 单组数据","多组数据"]
        return dataSource
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = self.view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        view.addSubview(tableView)
        
    }
}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc : UIViewController
        
        switch (indexPath.row) {
            case 0:
                vc = TestViewController()
            case 1:
                vc = SimpleBarChartsViewController()
            case 2:
                vc = GroupsBarChartsViewController()
            default:
                vc = UIViewController()
                break;
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

