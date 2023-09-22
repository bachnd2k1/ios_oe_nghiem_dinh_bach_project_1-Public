//
//  SearchCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 21/09/2023.
//

import UIKit
protocol SearchCellDelegate: AnyObject {
    func didTapItem(youtube: Youtube, movie: Movie)
}

final class SearchCell: UITableViewCell {
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    private var movie: Movie?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction private func playButtonClick(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCell(movie: Movie) {
        self.movie = movie
        nameLabel.text = movie.originalTitle
        guard let path = movie.posterPath else {
            return
        }
        let url = EndPoint.baseURLImage + path
        Utils.loadImageFromURL(url) { [weak self] (image) in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.previewImageView.image = image
                }
            }
        }
    }
}
