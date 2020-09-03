//
//  FirstModel.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import YLExtensions

struct Chapter {
    let name: String
}

struct FirstModel: ModelType {
    let chapters: [Chapter]
    var data: [[Any]]?
    
    init(chapters: [Chapter]) {
        self.chapters = chapters
        self.data = [chapters]
    }
}

extension FirstModel {
    // 所有以纯代码方式创建的 cell
    static var tCells: [UITableViewCell.Type]? {
        [UITableViewCell.self]
    }
    
    // 所有以 nib 方式创建的 cell
//    static var tNibs: [UITableViewCell.Type]? {
//
//    }
    
    // 所有 cell，以显示顺序排列
    static var tAll: [UITableViewCell.Type]? {
        [UITableViewCell.self]
    }
}
