//
//  SecondModel.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import YLExtensions

struct CiSummary: Decodable {
    let title: String
    let author: String
}

struct SecondModel: ModelType {
    let ciSummaries: [CiSummary]
    var nextPage: Int?
    var data: [[Any]]?
    
    init(ciList: [CiSummary], nextPage: Int?) {
        self.ciSummaries = ciList
        self.nextPage = nextPage
        self.data = [ciList]
    }
}

extension SecondModel {
    static var tCells: [UITableViewCell.Type]? {
        [CiSummaryCell.self]
    }
    
    static var tAll: [UITableViewCell.Type]? {
        [CiSummaryCell.self]
    }
}
