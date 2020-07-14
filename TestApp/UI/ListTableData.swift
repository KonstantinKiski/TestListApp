//
//  ListTableData.swift
//  TestApp
//
//  Created by Константин Киски on 14.07.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import UIKit

class ListTableData {
    
    // MARK: - Enums
    
    enum ListCell: String {
        case hz = "hz"
        case selector = "selector"
        case picture = "picture"
    }
    
    // MARK: - Variables
    
    private var cachedData: [TableData]! = []
    private var listData: [ListResponce]!
    private var views: [String]!
    private var itemsSelector: [Variants]?
    private var currentVariant: Variants?

    // MARK: - Initilized func
    
    /// Инициализация TableData для ListViewController, контроллера со списком
    ///
    /// - list: Cписок данных
    /// - views: Расположение ячеек
    func update(list: [ListResponce], views: [String]) {
        self.listData = list
        self.views = views
        
        self.itemsSelector = listData.filter({$0.name == "selector"}).first?.additions?.variants
        self.currentVariant = itemsSelector?.first

        update()
    }
    
    /// Обновление варианта
    ///
    /// - variant: Выбранный вариант
    func update(variant: Variants) {
        self.currentVariant = variant
        
        update()
    }
    
    func update() {
        let tableDataBuilder : TableDataBuilder = TableDataBuilder()
        cachedData.removeAll()
        
        tableDataBuilder.addSection()
        tableDataBuilder.addRows(rowsIndentifire: views)
        
        cachedData = tableDataBuilder.generateTableData()
    }
    
    // MARK: - Return functions
    
    func returnVariants() -> [Variants] {
        return itemsSelector ?? [Variants]()
    }
    
    func returnCurrentVariant() -> Variants {
        return currentVariant ?? Variants()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func getSectionCount() -> Int {
        return cachedData.filter({ $0.rowsData!.count > 0 || ($0.rowsIndentifier?.count)! > 0}).count
    }
    
    func getItemsInSectionCount(section: Int) -> Int {
        if cachedData.filter({ $0.rowsData!.count > 0 || ($0.rowsIndentifier?.count)! > 0})[section].rowsIndentifier?.count != 0 {
            return cachedData.filter({ $0.rowsData!.count > 0 || ($0.rowsIndentifier?.count)! > 0})[section].rowsIndentifier!.count
        }
        return cachedData.filter({ $0.rowsData!.count > 0 || ($0.rowsIndentifier?.count)! > 0})[section].rowsData!.count
    }
    
    func getIdentifireCellByIndexPath(path: IndexPath) -> String? {
        if cachedData.filter({ $0.rowsData!.count > 0 || ($0.rowsIndentifier?.count)! > 0})[path.section].rowsIndentifier?.count != 0  {
            return cachedData.filter({ $0.rowsData!.count > 0 || ($0.rowsIndentifier?.count)! > 0})[path.section].rowsIndentifier?[path.row]
        }
        return cachedData.filter({ $0.rowsData!.count > 0 || ($0.rowsIndentifier?.count)! > 0})[path.section].indentifier
    }
    
    func setData(to cell: UITableViewCell, by indexPath: IndexPath) -> UITableViewCell? {
        let cellType = ListCell(rawValue: cell.reuseIdentifier ?? "")
        switch cellType {
            case .hz?:
                let hzCell = cell as? DefaultTableViewCell
                
                let dataHz = listData.filter({$0.name == "hz"}).first
                hzCell?.setData(data: DefaultTableViewCell.DataCell(title: dataHz?.name, descriptionTitle: dataHz?.additions?.text))
                
                return hzCell
            case .picture?:
                let pictureCell = cell as? DefaultTableViewCell
                
                let dataPicture = listData.filter({$0.name == "picture"}).first
                pictureCell?.setData(data: DefaultTableViewCell.DataCell(title: dataPicture?.name, descriptionTitle: dataPicture?.additions?.text, imageUrl: dataPicture?.additions?.url))

                return pictureCell
            case .selector?:
                let selectorCell = cell as? DefaultTableViewCell
                selectorCell?.setData(data: DefaultTableViewCell.DataCell(title: currentVariant?.text))
                return selectorCell
            default:
                return cell
        }
    }
}
