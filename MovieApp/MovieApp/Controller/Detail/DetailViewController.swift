//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Bach Nghiem on 20/09/2023.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var baseURLVideo: String?
    var movie: Movie?
    var movies = [Movie]()
    private let coreDataRepo = CoreDataRepositoryImpl()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.register(
            UINib(nibName: String(describing: ItemBannerTableViewCell.self),
                  bundle: nil), forCellReuseIdentifier: Constant.Cell.banner)
        tableView.register(
            UINib(nibName: String(describing: InteractiveTableViewCell.self),
                  bundle: nil), forCellReuseIdentifier: Constant.Cell.interactive)
        tableView.register(
            UINib(nibName: String(describing: ActorCollectionViewCell.self),
                  bundle: nil), forCellReuseIdentifier: Constant.Cell.actor)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        getActorList()
    }
    
    func config(baseURLVideo: String, movie: Movie) {
        self.movie = movie
        self.baseURLVideo = baseURLVideo
    }
    
    func getActorList() {
        ApiCaller.shared.getUpcomingMovie { [weak self] results in
            guard let self = self else { return } 
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

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Space.heightOfCellDetail
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getBannerCell(tableView: tableView, indexPath: indexPath)
        case 1:
            return getInteractiveCell(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func getBannerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.banner, for: indexPath) as? ItemBannerTableViewCell else { return UITableViewCell()}
        if let baseURLVideo = baseURLVideo, let movie = movie {
            cell.configCell(endPointURL: baseURLVideo, movie: movie)
        }
        return cell
    }
    
    func getInteractiveCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.interactive, for: indexPath) as? InteractiveTableViewCell else { return UITableViewCell()}
        if let name = movie?.title {
            cell.setName(name: name)
        }
        cell.delegate = self
        return cell
    }
    
    func getActorCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.actor, for: indexPath) as? ActorCollectionViewCell else { return UITableViewCell()}
        cell.configCell(movies: movies)
        return cell
    }
}

extension DetailViewController: InteractiveTableViewCellDelegate {
    func addFavouriteList() {
        if let baseURLVideo = baseURLVideo, let movie = movie {
            coreDataRepo.add(movie: movie, baseURLVideo: baseURLVideo)
        }
    }
    
    func removeFavouriteList() {
        if let movie = movie {
            coreDataRepo.remove(name: movie.title)
        }
    }
}
