//
//  DefaultTableViewCell.swift
//  TestApp
//
//  Created by Константин Киски on 14.07.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DefaultTableViewCell: UITableViewCell {
    
    // MARK: - Structure data
    
    struct DataCell {
        var title: String!
        var descriptionTitle: String?
        var imageUrl: String?
    }
    
    // MARK: - UI Elements
    
    @IBOutlet private weak var titleCell: UILabel!
    @IBOutlet private weak var descriptionCell: UILabel?
    @IBOutlet private weak var imageCell: UIImageView?
    
    // MARK: - Set data
    
    func setData(data: DataCell) {
        titleCell.text = data.title
        descriptionCell?.text = data.descriptionTitle ?? ""
        imageCell?.sd_setImage(with: URL(string: data.imageUrl ?? ""), placeholderImage: nil)
    }
    
}
