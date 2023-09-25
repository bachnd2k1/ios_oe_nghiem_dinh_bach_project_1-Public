//
//  ActorViewCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 25/09/2023.
//

import UIKit

final class ActorViewCell: UICollectionViewCell {
    @IBOutlet private weak var nameActorLabel: UILabel!
    @IBOutlet private weak var actorImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(movie: Movie) {
        nameActorLabel.text = movie.releaseDate
        guard let path = movie.posterPath else { return }
        let url = EndPoint.baseURLImage + path
        Utils.loadImageFromURL(url) { [weak self] (image) in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.actorImageView.image = image
                }
            }
        }
    }
}
