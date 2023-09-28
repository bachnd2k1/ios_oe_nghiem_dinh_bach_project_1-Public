//
//  Extension.swift
//  MovieApp
//
//  Created by Bach Nghiem on 18/09/2023.
//

import UIKit
import Foundation

extension UIViewController {
    func showAlertError(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
