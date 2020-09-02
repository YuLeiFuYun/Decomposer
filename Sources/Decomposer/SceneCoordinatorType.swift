//
//  SceneCoordinatorType.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/25.
//

import Foundation

public protocol SceneCoordinatorType {
    /// transition to another scene
    func transition(to scene: SceneType, type: SceneTransitionType)
    /// pop scene from navigation stack or dismiss current modal
    func pop(animated: Bool)
}

extension SceneCoordinatorType {
    public func pop() {
        pop(animated: true)
    }
}
