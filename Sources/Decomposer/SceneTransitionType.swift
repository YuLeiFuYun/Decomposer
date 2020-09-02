//
//  SceneTransitionType.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/25.
//

import Foundation

public enum SceneTransitionType {
    case root       // Let the view controller be the root view controller
    case push       // push view controller to navigation stack
    case model      // present view controller modally
}
