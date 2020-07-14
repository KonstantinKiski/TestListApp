//
//  ListViewController.swift
//  TestApp
//
//  Created by Константин Киски on 14.07.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import UIKit
import Foundation

class ListViewController: UIViewController {

    // MARK: -  UI Elements
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    private var tableData: ListTableData?
    
    // MARK: -  Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableData = ListTableData()
        getList()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: SelectorPopupViewController.self) {
            let controller = segue.destination as! SelectorPopupViewController
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .crossDissolve
            controller.items = tableData?.returnVariants()
            controller.currentItem = tableData?.returnCurrentVariant()
            controller.updateVariant = { variant in
                self.tableData?.update(variant: variant)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: -  Networking
    
    private func getList() {
        NetworkManager.List.getList() { data, error  in
            DispatchQueue.main.async {
                guard error == nil else {
                    return
                }
                self.tableData?.update(list: data.list ?? [ListResponce](), views: data.view ?? [String]())
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData?.getSectionCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.getItemsInSectionCount(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableData?.getIdentifireCellByIndexPath(path: indexPath) == "selector" {
            self.performSegue(withIdentifier: "openPopup", sender: nil)
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (tableData?.getIdentifireCellByIndexPath(path: indexPath))!, for: indexPath)
        return tableData?.setData(to: cell, by: indexPath) ?? cell
    }
}
