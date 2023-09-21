//
//  UpcomingViewController.swift
//  MovieApp
//
//  Created by Bach Nghiem on 20/09/2023.
//

import UIKit

final class UpcomingViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = "Upcoming"
        if let navigationController = navigationController {
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        tableView.register(
            UINib(nibName: String(describing: ComingSoonCell.self),
                  bundle: nil), forCellReuseIdentifier: Constant.Cell.comingsoon)
        tableView.delegate = self
        tableView.dataSource = self
        fetchUpcoming()
    }
    private func fetchUpcoming() {
        ApiCaller.shared.getUpcomingMovie { [weak self] results in
            switch results {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        guard let name = movie.originalTitle else {
            return
        }
        ApiCaller.shared.getVideoYoutube(with: name) { [weak self] result in
            switch result {
            case .success(let youtube):
                DispatchQueue.main.async {
                    let viewController = DetailViewController()
                    viewController.config(youtube: youtube, movie: movie)
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            case .failure(let error):
                self?.showAlertError(message: "error+ \(error)")
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Space.heightOfCell
    }
}

extension UpcomingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.Cell.comingsoon, for: indexPath)
                as? ComingSoonCell else {return UITableViewCell()}
        let movie = movies[indexPath.row]
        cell.delegate = self
        cell.configCell(movie: movie)
        return cell
    }
}

extension UpcomingViewController: ComingSoonCellDelegate {
    func openDetailVC(movie: Movie, youtube: Youtube) {
        let detailVC = DetailViewController()
        detailVC.config(youtube: youtube, movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func notification(movie: Movie) {
        guard let releaseDate = movie.releaseDate else { return }
        let alert = UIAlertController(title: "Set a reminder on \(releaseDate)?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard self != nil else { return }
            let content = UNMutableNotificationContent()
            content.title = "Movie Release!!"
            content.body = "\(String(describing: movie.originalTitle)) is coming today!"
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            let request = UNNotificationRequest(identifier: "RemindMeIdentifier", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    func showError(error: String) {
        showAlertError(message: error)
    }
}
