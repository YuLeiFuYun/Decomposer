//
//  CustomRefreshOperator.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/9/1.
//

import YLRefreshKit

class CustomRefreshOperator<DS: DataSourceType, NM: NetworkManagerType>: RefreshOperator<DS, NM> where DS.Model == NM.Model {
    override func startTransition(_ state: RefreshState) {
        print("startTransition")
    }
    
    override func endTransition(_ state: RefreshState) {
        print("endTransition")
    }
    
    override func errorHandling(_ error: Error) -> RefreshState {
        // 错误处理
        print("errorHandling")
        return .error(error)
    }
}
