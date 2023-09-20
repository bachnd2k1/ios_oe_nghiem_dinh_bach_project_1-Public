//
//  HeaderView.swift
//  MovieApp
//
//  Created by Bach Nghiem on 20/09/2023.
//

import UIKit

final class HeaderView: UIView {
    static func loadFromNib() -> UIView {
        let nib = UINib(nibName: "HeaderCell", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? HeaderView else {
            return UIView()
        }
        return view
    }
}
