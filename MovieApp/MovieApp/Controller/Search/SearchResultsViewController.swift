//
//  SearchResultsViewController.swift
//  MovieApp
//
//  Created by Bach Nghiem on 22/09/2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapItem(youtube: Youtube, movie: Movie)
    func showError(error: String)
}

final class SearchResultsViewController: UIViewController {
    private let searchResultsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Constant.Space.widthOfCollectionResult, height: Constant.Space.heightOfCollectionResult)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: Constant.Cell.movie)
        return collectionView
    }()
    public var movies = [Movie]()
    public weak var delegate: SearchResultsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsCollectionView.backgroundColor = .black
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    func reloadData() {
        searchResultsCollectionView.reloadData()
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Cell.movie, for: indexPath) as? MovieCell else { return UICollectionViewCell()}
        let movie = movies[indexPath.row]
        guard let posterPath = movie.posterPath else {return UICollectionViewCell()}
        cell.configure(posterURL: posterPath)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let name = movie.originalTitle ?? ""
        ApiCaller.shared.getVideoYoutube(with: name) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    self?.delegate?.didTapItem(youtube: videoElement, movie: movie)
                }
            case .failure(let error):
                let err = "error + \(error)"
                self?.delegate?.showError(error: err)
            }
        }
    }
}
