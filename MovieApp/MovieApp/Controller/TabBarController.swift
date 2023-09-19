//
//  TabBarController.swift
//  MovieApp
//
//  Created by Bach Nghiem on 14/09/2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    private func config() {
        let homeVC = UINavigationController(rootViewController: Constant.ViewController.HOME)
        let upComingVC = UINavigationController(rootViewController: Constant.ViewController.UPCOMING)
        let searchVC = UINavigationController(rootViewController: Constant.ViewController.SEARCH)
        let downloadVC = UINavigationController(rootViewController: Constant.ViewController.DOWNLOAD)
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        upComingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        homeVC.title = Constant.Title.HOME
        upComingVC.title =  Constant.Title.UPCOMING
        searchVC.title = Constant.Title.SEARCH
        downloadVC.title = Constant.Title.DOWNLOAD
        tabBar.barTintColor = .black
        setViewControllers([homeVC, upComingVC, searchVC, downloadVC], animated: true)
    }
}
