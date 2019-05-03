//
//  UIViewController+Extension.swift
//  Breather
//
//  Created by Alexandros Baramilis on 30/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Presents an alert with a title, message and a default OK action.
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
