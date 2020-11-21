//
//  Scene.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import Decomposer
import YLStateMachine
import YLRefreshKit

enum Scene: SceneType {
    case first(FirstViewModel)
    case second(SecondViewModel)
    case third(ThirdViewModel)
    
    var viewController: UIViewController {
        switch self {
        case .first(let viewModel):
            let refreshOperator = CustomRefreshOperator(dataSource: viewModel, networkManager: NetworkManager<FirstModel>(), target: Target.first)
            let firstViewController = FirstViewController(refreshOperator: refreshOperator)
            let navigationController = UINavigationController(rootViewController: firstViewController)
            return navigationController
        case .second(let viewModel):
            let refreshOperator = CustomRefreshOperator(dataSource: viewModel, networkManager: NetworkManager<SecondModel>(), target: Target.second(chapterNumber: 0, page: 0))
            let secondVC = SecondViewController(refreshOperator: refreshOperator)
            secondVC.title = chapters[viewModel.targetInfo as! Int].name
            return secondVC
        case .third(let viewModel):
            let refreshOperator = CustomRefreshOperator(dataSource: viewModel, networkManager: NetworkManager<ThirdModel>(), target: Target.third(chapterNumber: 0, ciNumber: 0))
            // 自定义 third view controller
            let thirdVC = ThirdViewController()
            thirdVC.refreshStateMachine = StateMachine(operator: refreshOperator)
            thirdVC.bindRefreshStateMachine { [weak thirdVC] in
                guard
                    let viewController = thirdVC,
                    let ciDetail = viewController.refreshStateMachine.operator.dataSource.model?.data[0][0] as? CiDetail
                else { return }
                
                viewController.titleLabel.text = ciDetail.title
                viewController.authorLabel.text = ciDetail.author
                
                let paragraphs = ciDetail.paragraphs
                let blanks = "      "
                switch paragraphs.count {
                case 2:
                    viewController.ciALabel.text = blanks + paragraphs[0]
                    viewController.ciBLabel.text = blanks + paragraphs[1]
                case 3:
                    viewController.ciALabel.text = blanks + paragraphs[0] + paragraphs[1]
                    viewController.ciBLabel.text = blanks + paragraphs[2]
                case 4:
                    viewController.ciALabel.text = blanks + paragraphs[0] + paragraphs[1]
                    viewController.ciBLabel.text = blanks + paragraphs[2] + paragraphs[3]
                default:
                    viewController.ciALabel.text = blanks + paragraphs[0] + paragraphs[1] + paragraphs[2]
                    viewController.ciBLabel.text = paragraphs.dropFirst(2).reduce(blanks, +)
                }
                
                viewController.commentTitleLabel.text = "注释"
                viewController.commentsLabel.text = ciDetail.notes.reduce("", { $0 + "\n" + $1 })
            }
            
            return thirdVC
        }
    }
}
