//
//  SceneCoordinator.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/25.
//

import UIKit

public class SceneCoordinator: NSObject, SceneCoordinatorType {
    private var window: UIWindow
    // 防止循环引用
    private weak var currentViewController: UIViewController?
    
    public required init(window: UIWindow) {
        self.window = window
    }
    
    public func transition(to scene: SceneType, type: SceneTransitionType) {
        let viewController = scene.viewController
        
        switch type {
        case .root:
            currentViewController = actualViewController(for: viewController)
            window.rootViewController = viewController
        case .push:
            guard let navigationController = currentViewController?.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            
            navigationController.delegate = self
            navigationController.pushViewController(viewController, animated: true)
        case .model:
            currentViewController?.present(viewController, animated: true, completion: nil)
            currentViewController = viewController
        }
    }
    
    public func pop(animated: Bool) {
        if let presenter = currentViewController?.presentingViewController {
            // dismiss a modal controller
            currentViewController?.dismiss(animated: true) {
                self.currentViewController = presenter
            }
        } else if let navigationController = currentViewController?.navigationController {
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(String(describing: currentViewController))")
            }
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(String(describing: currentViewController))")
        }
    }
}

extension SceneCoordinator: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        currentViewController = viewController
    }
}

private extension SceneCoordinator {
    func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let tabBatController = viewController as? UITabBarController {
            let first = tabBatController.viewControllers?.first
            if let navigationController = first as? UINavigationController {
                return navigationController.viewControllers.first!
            } else {
                return first!
            }
        } else if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }
}
