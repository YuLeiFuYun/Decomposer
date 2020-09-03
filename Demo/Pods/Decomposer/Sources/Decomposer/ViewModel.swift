//
//  ViewModel.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/25.
//

import YLExtensions
import YLRefreshKit

open class ViewModel<Model: ModelType>:
    NSObject,
    DataSourceType,
    SceneRouterType,
    UITableViewDataSource,
    UICollectionViewDataSource
{
    // SceneRouterType 的要求
    public var sceneCoordinator: SceneCoordinatorType
    
    // DataSourceType 的要求
    public var model: Model?
    public var targetInfo: Any?
    
    public init(sceneCoordinator: SceneCoordinatorType, targetInfo: Any? = nil) {
        self.sceneCoordinator = sceneCoordinator
        self.targetInfo = targetInfo
    }
    
    // MARK: - UITableViewDataSource
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        model == nil ? 0 : model!.data!.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model == nil ? 0 : model!.data![section].count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: Model.tAll!)
        cell.configure(model!.data![indexPath.section][indexPath.row])
        
        return cell
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        nil
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        nil
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        0
    }
    
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        model == nil ? 0 : model!.data!.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model == nil ? 0 : model!.data![section].count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, with: Model.cAll!)
        cell.configure(model!.data![indexPath.section][indexPath.row])
        
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        false
    }
    
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    open func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        IndexPath(row: 0, section: 0)
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        UICollectionReusableView()
    }
}
