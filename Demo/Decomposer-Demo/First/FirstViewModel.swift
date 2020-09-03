//
//  FirstViewModel.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import Decomposer

class FirstViewModel: ViewModel<FirstModel>, UITableViewDelegate {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: Model.tAll!)
        
        guard let content = model!.data![indexPath.section][indexPath.row] as? Chapter else { fatalError() }
        cell.textLabel?.text = content.name
        cell.textLabel?.font = .systemFont(ofSize: 23)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = SecondViewModel(sceneCoordinator: sceneCoordinator, targetInfo: indexPath.row)
        sceneCoordinator.transition(to: Scene.second(viewModel), type: .push)
    }
}
