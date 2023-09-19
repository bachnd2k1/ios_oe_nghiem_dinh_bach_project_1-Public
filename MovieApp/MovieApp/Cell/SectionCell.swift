//
//  HomeMovieCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 18/09/2023.
//

import UIKit

final class SectionCell: UITableViewCell {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: Constant.Space.widthForRow, height: Constant.Space.heightForRow)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: Constant.Cell.movie)
        return collectionView
    }()
    private var movies: [Movie] = [Movie]()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        backgroundColor = .black
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(
            x: Constant.Space.marginSmall,
            y: Constant.Space.emptyMargin,
            width: contentView.bounds.width - Constant.Space.marginSmall,
            height: contentView.bounds.height
        )
    }
    public func configure(with movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension SectionCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return movies.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.Cell.movie, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        guard let posterPath = movies[indexPath.row].posterPath else {return UICollectionViewCell()}
        cell.configure(posterURL: posterPath)
        return cell
    }
}
