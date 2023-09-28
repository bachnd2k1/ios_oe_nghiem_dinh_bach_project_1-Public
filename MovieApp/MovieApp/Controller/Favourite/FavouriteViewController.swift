//
//  FavouriteViewController.swift
//  MovieApp
//
//  Created by Bach Nghiem on 14/09/2023.
//

import UIKit

final class FavouriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let coreDataRepo = CoreDataRepositoryImpl()
    var myListArray = [MovieLocal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fetchDataFromCoreData()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("NewItemAddedToFavorite"), object: nil)
    }
    @objc func updateData() {
        fetchDataFromCoreData()
    }
    
    func config() {
        title = "MyList"
        view.backgroundColor = .black
        if let navigationController = navigationController {
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        tableView.register(
            UINib(nibName: String(describing: FavouriteCell.self),
                  bundle: nil), forCellReuseIdentifier: Constant.Cell.favourite)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
    }
    
    func fetchDataFromCoreData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.myListArray = self.coreDataRepo.getAll()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.favourite, for: indexPath) as? FavouriteCell else { return UITableViewCell()}
        let coreData = myListArray[indexPath.row]
        let movie = Utils.convertCoreDataToMovie(coreData: coreData)
        cell.configCell(movie: movie)
        return cell
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coreData = myListArray[indexPath.row]
        let movie = Utils.convertCoreDataToMovie(coreData: coreData)
        let viewController = DetailViewController()
        guard let endPointURl = coreData.urlVideo else { return }
        viewController.config(baseURLVideo: endPointURl, movie: movie)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let item = myListArray[indexPath.row]
            if let name = item.name {
                coreDataRepo.remove(name: name)
                myListArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}
