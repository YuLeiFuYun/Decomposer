//
//  NetworkManager.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import YLExtensions
import YLRefreshKit

let chapters = [Chapter(name: "序"), Chapter(name: "卷第一"), Chapter(name: "卷第二"), Chapter(name: "卷第三"), Chapter(name: "卷第四"), Chapter(name: "卷第五"), Chapter(name: "卷第六"), Chapter(name: "卷第七"), Chapter(name: "卷第八"), Chapter(name: "卷第九"), Chapter(name: "卷第十")]
fileprivate let jsonFileNames = ["huajianji-0-preface", "huajianji-1-juan", "huajianji-2-juan", "huajianji-3-juan", "huajianji-4-juan", "huajianji-5-juan", "huajianji-6-juan", "huajianji-7-juan", "huajianji-8-juan", "huajianji-9-juan", "huajianji-x-juan"]

struct NetworkManager<Model: ModelType>: NetworkManagerType {
    func request(target: Target, completion: @escaping (Result<Model, Error>) -> Void) {
        switch target {
        case .first:
            let model = FirstModel(chapters: chapters)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(model as! Model))
            }
        case .second(let chapterNumber, let page):
            let jsonURL = Bundle.main.url(forResource: jsonFileNames[chapterNumber], withExtension: "json")!
            let data = try! Data(contentsOf: jsonURL)
            let ciSummaries = try! JSONDecoder().decode([CiSummary].self, from: data)
            let nextPage = (ciSummaries.count - 20 * page) <= 0 ? nil : page + 1
            let start = 20 * (page - 1)
            let end = (nextPage == nil) ? ciSummaries.count : 20 * page
            let model = SecondModel(ciSummaries: Array(ciSummaries[start..<end]), nextPage: nextPage)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(model as! Model))
            }
        case .third(let chapterNumber, let ciNumber):
            let jsonURL = Bundle.main.url(forResource: jsonFileNames[chapterNumber], withExtension: "json")!
            let data = try! Data(contentsOf: jsonURL)
            let ciDetails = try! JSONDecoder().decode([CiDetail].self, from: data)
            let model = ThirdModel(ci: [ciDetails[ciNumber]])
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(model as! Model))
            }
        }
    }
}
