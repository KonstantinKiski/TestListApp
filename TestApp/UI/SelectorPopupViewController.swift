//
//  SelectorPopupViewController.swift
//  TestApp
//
//  Created by Константин Киски on 14.07.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import UIKit

class SelectorPopupViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: - UI Elements
    
    @IBOutlet private weak var dismissView: UIView!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    // MARK: - Variables
    
    public var items: [Variants]!
    public var currentItem: Variants?
    
    // MARK: - Closure
    
    var updateVariant: (Variants) -> Void = { _ in }

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismiss()
        pickerView.selectRow(items.firstIndex(where: {$0 == currentItem}) ?? 0, inComponent: 0, animated: false)
    }
        
    // MARK: - Set gesture
    
    private func setDismiss() {
         let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.dismissAction (_:)))
         self.dismissView.addGestureRecognizer(gesture)
    }
    
    @objc func dismissAction(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension SelectorPopupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateVariant(items[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].text
    }
}

