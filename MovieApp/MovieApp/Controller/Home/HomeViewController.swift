//
//  ViewController.swift
//  MovieApp
//
//  Created by Bach Nghiem on 13/09/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    let sectionTitles = [
        "Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"
    ]

    @IBOutlet weak var tableView: UITableView!
    private var trendingMovie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.register(SectionCell.self, forCellReuseIdentifier: Constant.Cell.section)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        let headerView = HeaderView.loadFromNib()
        tableView.tableHeaderView = headerView
        configureNavBar()
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        ApiCaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let movie = movies.randomElement()
                self?.trendingMovie = movie
                guard let posterPath = self?.trendingMovie?.posterPath else { return }
                let url = EndPoint.baseURLImage + posterPath
                Utils.loadImageFromURL(url) { [weak self] (image) in
                    guard let self = self else { return }
                    if let image = image {
                        DispatchQueue.main.async {
                        }
                    }
                }
            case .failure(let error):
                self?.showAlertError(message: "error + \(error)")
            }
        }
    }
    
    private func configureNavBar() {
        let image = UIImage(named: Constant.Image.netflixImage)?.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.tintColor = .white
    }
    private func handleAPIResponse(result: Result<[Movie], Error>, cell: SectionCell) {
        switch result {
        case .success(let movies):
            cell.configure(with: movies)
        case .failure(let error):
            showAlertError(message: "error +\(error)")
        }
    }
    @objc func refreshData(_ sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.Cell.section, for: indexPath) as? SectionCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Constant.Sections.trendingMovies.rawValue:
            ApiCaller.shared.getTrendingMovies { self.handleAPIResponse(result: $0, cell: cell) }
        case Constant.Sections.trendingTv.rawValue:
            ApiCaller.shared.getTrendingTVs { results in
                switch results {
                case .success(let tvShows):
                    let movies = Utils.convertToMovie(tvShows: tvShows)
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Constant.Sections.popular.rawValue:
            ApiCaller.shared.getPopularMovies { self.handleAPIResponse(result: $0, cell: cell) }
        case Constant.Sections.upcoming.rawValue:
            ApiCaller.shared.getUpcomingMovie { self.handleAPIResponse(result: $0, cell: cell) }
        case Constant.Sections.topRated.rawValue:
            ApiCaller.shared.getTopRatedMovies { self.handleAPIResponse(result: $0, cell: cell) }
        default:
            return UITableViewCell()
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Space.heightForRow
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Space.heightForSection
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.textColor = .white
        let sectionTitle = sectionTitles[section]
        let words = sectionTitle.components(separatedBy: " ")
        let capitalizedWords = words.map { $0.prefix(1).capitalized + $0.dropFirst() }
        header.textLabel?.text = capitalizedWords.joined(separator: " ")
    }
}

extension HomeViewController: SectionCellCellDelegate {
    func showError(error: String) {
        showAlertError(message: error)
    }
    func didTapSectionCell(movie: Movie, youtube: Youtube) {
        let viewController = DetailViewController()
        viewController.config(baseURLVideo: youtube.id.videoId, movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
