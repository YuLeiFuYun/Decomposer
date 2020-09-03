//
//  FirstViewController.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import YLRefreshKit

class FirstViewController: TViewController<FirstViewModel, NetworkManager<FirstModel>, CustomRefreshOperator<FirstViewModel, NetworkManager<FirstModel>>> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "花间集"
        
        guard let tableView = refreshableView as? UITableView else { return }
        
        tableView.delegate = refreshStateMachine.operator.dataSource
        tableView.setAutoRefresh(refreshStateMachine: refreshStateMachine)
    }
}
