//
//  InteractiveTableViewCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 25/09/2023.
//

import UIKit

final class InteractiveTableViewCell: UITableViewCell {
    @IBOutlet private weak var myListButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var seeMoreButton: UIButton!
    
    @IBAction private func handleListButton(_ sender: Any) {

    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
