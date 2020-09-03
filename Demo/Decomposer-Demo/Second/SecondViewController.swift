//
//  SecondViewController.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import YLRefreshKit

class SecondViewController: TViewController<SecondViewModel, NetworkManager<SecondModel>, CustomRefreshOperator<SecondViewModel, NetworkManager<SecondModel>>> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tableView = refreshableView as? UITableView else { return }
        
        tableView.delegate = refreshStateMachine.operator.dataSource
        tableView.setAutoRefresh(refreshStateMachine: refreshStateMachine)
    }
}
