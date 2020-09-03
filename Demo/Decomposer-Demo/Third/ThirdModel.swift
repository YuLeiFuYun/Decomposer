//
//  ThirdModel.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/29.
//

import YLExtensions

struct CiDetail: Decodable {
    let title: String
    let author: String
    let paragraphs: [String]
    let notes: [String]
}

struct ThirdModel: ModelType {
    let ci: CiDetail
    var data: [[Any]]?
    
    init(ci: CiDetail) {
        self.ci = ci
        self.data = [[ci]]
    }
}
