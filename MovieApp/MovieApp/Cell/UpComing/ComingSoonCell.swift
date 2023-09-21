//
//  ComingSoonCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 21/09/2023.
//

import UIKit

protocol ComingSoonCellDelegate: AnyObject {
    func notification(movie: Movie)
    func openDetailVC(movie: Movie, youtube: Youtube)
    func showError(error: String)
}

final class ComingSoonCell: UITableViewCell {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var notificationButton: UIButton!
    @IBOutlet private weak var infoButton: UIButton!
    
    weak var delegate: ComingSoonCellDelegate?
    private var movie: Movie?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func notificationClick(_ sender: Any) {
        guard let movie = movie else { return }
        delegate?.notification(movie: movie)
    }
    @IBAction private func infoClick(_ sender: Any) {
        guard let movie = movie else { return }
        guard let name = movie.originalTitle else {
            return
        }
        ApiCaller.shared.getVideoYoutube(with: name) { [weak self] result in
            switch result {
            case .success(let youtube):
                DispatchQueue.main.async {
                    self?.delegate?.openDetailVC(movie: movie, youtube: youtube)
                }
            case .failure(let error):
                let error = "error+ \(error)"
                self?.delegate?.showError(error: error)
            }
        }
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCell(movie: Movie) {
        self.movie = movie
        dateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        nameLabel.text = movie.originalTitle
        guard let path = movie.posterPath else {
            return
        }
        let url = EndPoint.baseURLImage + path
        Utils.loadImageFromURL(url) { [weak self] (image) in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
    }
}
