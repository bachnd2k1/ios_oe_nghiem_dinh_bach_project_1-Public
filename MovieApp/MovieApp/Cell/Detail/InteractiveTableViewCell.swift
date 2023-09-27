//
//  InteractiveTableViewCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 25/09/2023.
//

import UIKit

protocol InteractiveTableViewCellDelegate {
    func addFavouriteList()
    func removeFavouriteList()
}

final class InteractiveTableViewCell: UITableViewCell {
    @IBOutlet private weak var myListButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var seeMoreButton: UIButton!
    var delegate: InteractiveTableViewCellDelegate?
    private let coreDataRepo = CoreDataRepositoryImpl()
    var name: String?
    
    @IBAction private func handleListButton(_ sender: Any) {
        guard let name = name else { return }
        let existsInFavourites = coreDataRepo.isExistInFavouriteList(name: name)
        let _ = existsInFavourites ? delegate?.removeFavouriteList() : delegate?.addFavouriteList()
        let _ = existsInFavourites ? myListButton.setImage(UIImage(systemName: "heart"), for: .normal) :
        myListButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        NotificationCenter.default.post(name: NSNotification.Name("NewItemAddedToFavorite"), object: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setName(name: String) {
        self.name = name
        let isExist = coreDataRepo.isExistInFavouriteList(name: name)
        myListButton.setImage(UIImage(systemName: isExist ? "heart.fill" : "heart"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
