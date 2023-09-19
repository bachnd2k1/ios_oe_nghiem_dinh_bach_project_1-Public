//
//  MoviesCollectionCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 18/09/2023.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(posterURL: String) {
        let url = EndPoint.baseURLImage + posterURL
        Utils.loadImageFromURL(url) { [weak self] (image) in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                }
            }
        }
    }
}
