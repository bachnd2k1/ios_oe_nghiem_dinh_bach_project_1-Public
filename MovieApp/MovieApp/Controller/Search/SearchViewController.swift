//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Bach Nghiem on 21/09/2023.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for Movie or a Tv Show"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.searchTextField.backgroundColor = UIColor.lightGray
        return controller
    } ()
    private var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fetchDiscoverMovies()
    }
    
    private func config() {
        title = "Search"
        if let navigationController = navigationController {
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        searchController.searchResultsUpdater = self
        tableView.register(
            UINib(nibName: String(describing: SearchCell.self),
                  bundle: nil), forCellReuseIdentifier: Constant.Cell.search)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
    }
    
    private func fetchDiscoverMovies() {
        ApiCaller.shared.getDiscoverMovies { [weak self] results in
            guard let self = self else {
                return
            }
            switch results {
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getSearchCell(tableView: tableView, indexPath: indexPath)
    }
    func getSearchCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.search, for: indexPath) as? SearchCell else { return UITableViewCell()}
        cell.configCell(movie: movies[indexPath.row])
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        guard let name = movie.originalTitle else {
            return
        }
        ApiCaller.shared.getVideoYoutube(with: name) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let youtube):
                DispatchQueue.main.async {
                    let viewController = DetailViewController()
                    viewController.config(youtube: youtube, movie: movie)
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            case .failure(let error):
                self.showAlertError(message: "error+ \(error)")
            }
        }
    }

}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func didTapItem(youtube: Youtube, movie: Movie) {
        let viewController = DetailViewController()
        viewController.config(youtube: youtube, movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
    }
    func showError(error: String) {
        showAlertError(message: error)
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        resultsController.delegate = self
        ApiCaller.shared.search(with: query) { results in
            DispatchQueue.main.async {
                switch results {
                case .success(let movies):
                    resultsController.movies = movies
                    resultsController.reloadData()
                case .failure(let error):
                    self.showAlertError(message: "error + \(error)" )
                }
            }
        }
    }
}
