# Decomposer
无论是 MVC、MVP 还是 MVVM 等构架模式，都是做为提纲挈领的指导思想而存在，并没有一个非常具体的操作规范，于是，我自己编写了一个……



## 优势

- 各个部分职责明确，项目结构清晰明了.
- 实现了刷新操作的自动化.
- 减少了项目代码量.



## 各部分介绍

- #### Scene

由 `SceneType` 协议规范。它是一个枚举类型，每个枚举成员关联着自身的 `ViewModel` 。它有一个 `viewController` 属性，正是在这里创建并自定义 `viewController` ，然后返回它。

- #### SceneCoordinator

由 `SceneCoordinatorType` 规范，继承自 `NSObject` 。它有一个 `transition(to:type:)` 方法，用以进行场景转换。它还有一个与之对应的 `pop()` 方法。

- #### Cell

藉由 `Configurable` 给它扩展了 `configure(_:)` 方法，你需要在此方法中配置 `cell` 。

- #### Model

由 `ModelType` 协议规范。它有一个可选的 `nextPage` 属性，加载下一页数据时会用的到；一个 `data` 属性，用以存储网络请求得来的被转化成模型的数据；它还有一些可选的类型属性，存储 `cell` 的类型，用以自动化注册及创建 `cell` 。

- #### Target

由 `TargetType` 协议规范。它是一个枚举类型，枚举成员会有一些关联值，存储着进行网络请求会用的到的一些信息，如页数等。它有一个 `isRefreshable` 的布尔属性，用以判断一个页面是否可以进行刷新操作；它还有一个可变的 `update(with:targetInfo:)` 方法，用于更新自身。

- #### NetworkManager

由 `NetworkManagerType` 协议规范。它有四个关联类型：`Target` 、`Model` 、`E` 和 `R` 。`Target` 遵循 `TargetType` 协议，表示将要请求的页面；`Model` 遵循 `ModelType` ，表示网络请求数据将要转化成的模型；`E` 遵循 `Error` 协议，表示错误；`R` 表示网络请求方法的返回类型，它可以是任意类型，比如，如果你使用 `Moya` 进行网络请求，你可以把返回值类型设为 `Cancellable` 。`R` 是可选的，即网络请求方法可以没有返回值。

- #### ViewModel

由 `ViewModel` 类定义。`ViewModel` 类继承自 `NSObject` 并遵循 `DataSourceType` 、`SceneRouterType` 、`UITableViewDataSource` 及 `UICollectionViewDataSource` 四个协议。`DataSourceType` 要求有一个遵循 `ModelType` 协议的 `model` 属性和一个 `targetInfo` 属性，`targetInfo` 用来存储 `target` 发生变化时可能需要的信息。`SceneRouterType` 要求有一个遵循 `SceneCoordinatorType` 协议的 `sceneCoordinator` ，用以进行场景转换。`UITableViewDataSource` 和 `UICollectionViewDataSource` 在实现刷新操作的自动化时用的到。你自身的 `ViewModel` 需要继承自 `ViewModel` 这个类。你可以将 `viewModel` 设置为 `tableView` 或 `collectionView` 的代理，然后在 `tableView(_:didSelectRowAt:)` 中实现页面跳转。

- #### RefreshOperator

由 `OperatorType` 协议规范。它勾连起 `DataSource`（一般就是一个 `ViewModel`）、`NetworkManager` 和 `Target` ，正是它调用 `networkManager` 发起了网络请求，并将返回的结果赋予 `dataSource` 的 `model` 。如果你需要对刷新错误进行处理或在刷新前后进行一些操作，请创建一个 `RefreshOperator` 的子类并实现相应的方法。

- #### StateMachine

指有限状态机。根据维基百科的定义，它是“表示有限个状态以及在这些状态之间的转移和动作等行为的数学计算模型”。在这里，它的作用是当发生刷新动作时调用 `RefreshOperator` 进行相关操作，然后改变刷新状态，最后调用 `completionHandler` 进行刷新后的一些处理。创建状态机需要提供一个遵循 `OperatorType` 协议的类型，对于刷新来说就是提供一个 `RefreshOperator` 或它的子类。

- #### Controller

要想在 `controller` 中使用状态机，你需要让它遵循并实现 `Refreshable` 协议。此协议规定了 `refreshableView` 和 `refreshStateMachine` 两个属性及 `bindRefreshStateMachine()` 和 `bindRefreshStateMachine(_:)` 两个方法。因为在扩展中给出了两个方法的实现，所以要实现此协议只需定义两个属性即可。为方便使用，定义了 `TViewController` 、`CViewController` 及 `SViewController` 三个类，分别对应页面是 `table view` 、`collection view` 和 `scroll view` 的情况。你可以让你的 `viewController` 继承自它们中的某一个，在 `viewDidLoad()` 中进行一些自定义的操作，然后调用 `refreshableView` 的

`setAutoRefresh(refreshStateMachine:)` 方法设置自动刷新。



## 环境要求

* iOS 13.0+
* Swift 5.1+



## 安装

### Cocoapods

在 `Podfile` 中添加：

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

target 'MyApp' do
  # your other pod
  # ...
  pod 'Decomposer'
end
```

然后运行 `pod install` 命令。



## 使用

首先，让 `Model` 遵循并实现 `ModelType` 协议：

```swift
import YLExtensions

struct Something {
    ...
}

struct SomeModel: ModelType {
    let something: [Something]
    
    // 可选属性
    var nextPage: Int?
    // 必要属性
    var data: [[Any]]?
    
    // 创建一个初始化方法初始化 data
    init(something: [Something], nextPage: Int? = nil) {
        self.something = something
        self.nextPage = nextPage
        self.data = [something]
    }
}

extension Something {
    // 若是 UITableView
    
    static var tCells: [UITableViewCell.Type]? {
        // 所有以纯代码形式创建的 cell 类型
        [ACell.self, BCell.self]
    }
    
    static var tNibs: [UITableViewCell.Type]? {
        // 所有以 nib 形式创建的 cell 类型
        [CCell.self, DCell.self]
    }
    // 必须实现
    static var tAll: [UITableViewCell.Type]? {
        // 所有 cell 类型，以显示顺序排列
        [ACell.self, BCell.self, CCell.self, DCell.self]
    }
    
    // 若是 UICollectionView
    
    static var cCells: [UICollectionViewCell.Type]? {
        // 所有以纯代码形式创建的 cell 类型
        ...
    }
    
    static var cNibs: [UICollectionViewCell.Type]? {
        // 所有以 nib 形式创建的 cell 类型
        ...
    }
    // 必须实现
    static var cAll: [UICollectionViewCell.Type]? {
        // 所有 cell 类型，以显示顺序排列
        ...
    }
    
    static var headViews: [UICollectionReusableView.Type]? {
        ...
    }
    
    static var footerViews: [UICollectionReusableView.Type]? {
        ...
    }
    
    static var headerNibs: [UICollectionReusableView.Type]? {
        ...
    }
    
    static var footerNibs: [UICollectionReusableView.Type]? {
        ...
    }
}
```

其次，在 `Cell` 的 `configure(_:)` 方法中配置 `view` ：

```swift
class SomeCell: UITableViewCell {
    override func configure(_ model: Any?) {
        ...
    }
}
```

接着，创建一个 target 让它遵循并实现 TargetType 协议：

```swift
import YLRefreshKit

enum SomeTarget: TargetType {
    case first(page: Int)
    case second(topicID: String, page: Int)
    ...
    
    // 是否能进行刷新操作。注意，不是指是否遵循 Refreshable 协议.
    var isRefreshable: Bool {
        switch self {
            ...
        }
    }
    
    // 更新 target
    mutating func update(with action: RefreshAction, targetInfo: Any?) {
        switch isRefreshable {
        case .first:
            // 没有更新 target 的需求可以提前返回
            return
        ....
        }
        
        switch action {
        case .pullToRefresh:
            switch self {
            case .first:
                self = .first(page: 1)
            case .second:
                self = .second(page: 1)
            }
        case .loadingMore:
            switch self {
            case .first(let page):
                self = .first(page: page + 1)
            case .second(_, let page):
                let topicID = targetInfo as! String
                self = .second(topicID: topicID, page: page + 1)
            ...
            }
        }
    }
}
```

然后，让 `NetworkManager` 遵循并实现 `NetworkManagerType` 协议：

```swift
struct NetworkManager<Model: ModelType>: NetworkManagerType {
    func request(target: Target, completion: @escaping (Result<Model, Error>) -> Void) {
        switch target {
        case .first:
            ...
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(model as! Model))
            }
        case .second(let page):
            ...
            let nextPage = ...
            let model = SecondModel(model: ..., nextPage: nextPage)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(model as! Model))
            }
            ...
    }
        
    // 或者
    func request(target: Target, completion: @escaping (Result<Model, Error>) -> Void) -> <一个任意的返回类型> {
        ...
    }
}
```

如果你需要处理刷新错误或在刷新前后进行一些操作，请创建一个继承自 `RefreshOperator` 的子类并实现相应的方法（如果没有这些需求，直接使用 `RefreshOperator` 即可）：

```swift
import YLRefreshKit

class CustomRefreshOperator<DS: DataSourceType, NM: NetworkManagerType>: RefreshOperator<DS, NM> where DS.Model == NM.Model {
    override func startTransition(_ state: RefreshState) {
        // 开始刷新前的一些操作
        ...
    }
    
    override func endTransition(_ state: RefreshState) {
        // 结束刷新后的一些操作
        ...
    }
    
    override func errorHandling(_ error: Error) -> RefreshState {
        // 错误处理
        ...
        return .error(error)
    }
}
```

接下来，创建你的 `view controller` ：

```swift
// 如果是一个 table view 页面，请继承 TViewController（collection view 页面请继承 CViewController，scroll view 页面继承 SViewController）：
import YLRefreshKit

class FirstViewController: TViewController<SomeViewModel, NetworkManager<SomeModel>, CustomRefreshOperator<SomeViewModel, NetworkManager<SomeModel>>> { 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自定义
        ...
        // 如果要进行页面跳转
        // dataSource 即是此页面的 viewModel
        refreshableView!.delegate = refreshStateMachine.operator.dataSource
        
        // 设置自动刷新
        refreshableView!.setAutoRefresh(refreshStateMachine: refreshStateMachine)
    }
}

// 如果你希望自定义 table view 的 header 或 footer
extension UIScrollView {
    func customAutoRefresh<DS: DataSourceType, NM: NetworkManagerType>(refreshStateMachine: StateMachine<RefreshOperator<DS, NM>>) where DS.Model == NM.Model {
        let header = ..
        let footer = ..
        // 然后请参照 AutoRefreshable.swift 页面中的实现
        ...
    }
}
// 之后在 view controller 中调用
override func viewDidLoad() {
    super.viewDidLoad()
    ...
    refreshableView!.customAutoRefresh(refreshStateMachine: refreshStateMachine)
}
```

创建一个 `Scene` 遵循并实现 `SceneType` 协议：

```swift
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
            // 如果首个 Controller 是 navigation controller
            let refreshOperator = CustomRefreshOperator(dataSource: viewModel, networkManager: NetworkManager<FirstModel>(), target: Target.first)
            let firstViewController = FirstViewController(refreshOperator: refreshOperator)
            let navigationController = UINavigationController(rootViewController: firstViewController)
            return navigationController
        case .second(let viewModel):
            let refreshOperator = CustomRefreshOperator(dataSource: viewModel, networkManager: NetworkManager<SecondModel>(), target: Target.second(page: 0))
            return SecondViewController(refreshOperator: refreshOperator)
        case .third(let viewModel):
            let refreshOperator = CustomRefreshOperator(dataSource: viewModel, networkManager: NetworkManager<ThirdModel>(), target: Target.third(page: 0))
            // 自定义
            let thirdVC = ThirdViewController()
            thirdVC.refreshStateMachine = StateMachine(operator: refreshOperator)
            thirdVC.bindRefreshStateMachine { [weak thirdVC] in
                // 刷新后的相关操作
                ...
            }
            
            return thirdVC
        }
    }
}
```

最后，在 `SceneDelegate` 的 `scene(_:willConnectTo:options:)` 方法中开始吧：

```swift
import Decomposer

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.windowScene = scene
    window?.makeKeyAndVisible()

    let sceneCoordinator = SceneCoordinator(window: window!)
    let viewModel = FirstViewModel(sceneCoordinator: sceneCoordinator)
    sceneCoordinator.transition(to: Scene.first(viewModel), type: .root)
}
```

啊，不要忘记创建你的 `ViewModel` ：

```swift
import Decomposer

class SecondViewModel: ViewModel<SecondModel> {}

// 如果要进行页面跳转
extension SecondViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let oldInfo = targetInfo as? Int else { return }
        
        let info = [oldInfo, indexPath.row]
        let viewModel = ThirdViewModel(sceneCoordinator: sceneCoordinator, targetInfo: info)
        sceneCoordinator.transition(to: Scene.third(viewModel), type: .push)
    }
}
```



## 鸣谢

场景路由部分脱胎于 [raywenderlich.com](https://www.raywenderlich.com/) 出品的，由 Florent Pillet, Junior Bontognali, Marin Todorov & Scott Gardner 共同编写的 《**RxSwift: Reactive Programming with Swift**》一书的最后一章 『Building a Complete RxSwift App』 的关联项目 **QuickTodo** ，在此表示感谢。



## License

Decomposer is released under the MIT license. See LICENSE for details.