//
//  ActorCollectionViewCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 25/09/2023.
//

import UIKit

final class ActorCollectionViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [Movie]()
    override func awakeFromNib() {
        super.awakeFromNib()
        configUICell()
    }
    
    func configCell(movies: [Movie]) {
        self.movies = movies
    }
    
    private func configUICell() {
        contentView.backgroundColor = .red
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 101, height: 195)
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = layout
        collectionView.register(
            UINib(nibName: String(describing: ActorViewCell.self),
                  bundle: nil), forCellWithReuseIdentifier: Constant.Cell.actorItem)
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension ActorCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Cell.actorItem, for: indexPath) as? ActorViewCell else
        { return UICollectionViewCell()}
        let movie = movies[indexPath.row]
        cell.configCell(movie: movie)
        return cell
    }
}


