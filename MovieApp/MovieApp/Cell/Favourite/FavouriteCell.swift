//
//  FavouriteCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 26/09/2023.
//

import UIKit

final class FavouriteCell: UITableViewCell {
    @IBOutlet private weak var nameMovie: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(movie: Movie) {
        nameMovie.text = movie.title
        guard let path = movie.posterPath else {
            return
        }
        let url = EndPoint.baseURLImage + path
        Utils.loadImageFromURL(url) { [weak self] (image) in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }
    
}
