//
//  Target.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/9/2.
//

import YLRefreshKit

enum Target: TargetType {
    case first
    case second(chapterNumber: Int, page: Int)
    case third(chapterNumber: Int, ciNumber: Int)
    
    var isRefreshable: Bool {
        switch self {
        case .second:
            return true
        default:
            return false
        }
    }
    
    mutating func update(with action: RefreshAction, targetInfo: Any?) {
        if case .first = self { return }
        
        switch self {
        case .second(_, let page):
            let chapterNumber = targetInfo as! Int
            
            switch action {
            case .pullToRefresh:
                self = .second(chapterNumber: chapterNumber, page: 1)
            case .loadingMore:
                self = .second(chapterNumber: chapterNumber, page: page + 1)
            }
        case .third:
            let info = targetInfo as! [Int]
            // 第三个页面不能刷新，也就不必判断 action 的类型
            self = .third(chapterNumber: info[0], ciNumber: info[1])
        default:
            fatalError()
        }
    }
}
