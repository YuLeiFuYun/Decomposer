//
//  SecondViewModel.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import Decomposer

class SecondViewModel: ViewModel<SecondModel>, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chapterNumber = targetInfo as? Int else { return }
        
        let info = [chapterNumber, indexPath.row]
        let viewModel = ThirdViewModel(sceneCoordinator: sceneCoordinator, targetInfo: info)
        sceneCoordinator.transition(to: Scene.third(viewModel), type: .push)
    }
}
