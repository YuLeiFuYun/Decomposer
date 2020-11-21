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

struct SecondModel {
    var ciSummaries: [CiSummary]
    var nextPage: Int?
}

extension SecondModel: ModelType {
    var pageablePropertyPath: WritableKeyPath<SecondModel, [CiSummary]>? {
        return \SecondModel.ciSummaries
    }
    
    var data: [[Any]] {
        return [ciSummaries]
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
