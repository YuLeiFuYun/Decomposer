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

struct ThirdModel {
    var ci: [CiDetail]
}

extension ThirdModel: ModelType {
    var pageablePropertyPath: WritableKeyPath<ThirdModel, [CiDetail]>? {
        return \ThirdModel.ci
    }
    
    var data: [[Any]] {
        return [ci]
    }
}
