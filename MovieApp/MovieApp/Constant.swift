//
//  Constant.swift
//  MovieApp
//
//  Created by Bach Nghiem on 18/09/2023.
//

import Foundation

class Constant {
    struct ViewController {
        static let HOME = HomeViewController()
        static let UPCOMING = UpcomingViewController()
        static let DOWNLOAD = DownloadViewController()
        static let SEARCH = SearchViewController()
    }
    struct Title {
        static let HOME = "Home"
        static let UPCOMING = "Upcoming"
        static let DOWNLOAD = "Download"
        static let SEARCH = "Search"
    }
    struct Space {
        static let widthButton = 100.0
        static let heightHeaderView = 450.0
        static let emptyMargin = 0.0
        static let zeroCordinate = 0.0
        static let marginBottom = -50.0
        static let marginSmall = 10.0
        static let marginNormal = 30.0
        static let widthForRow = 140.0
        static let heightForRow = 200.0
        static let heightForSection = 40.0
        static let fontSize = 14.0
    }
    struct Image {
        static let netflixImage = "netflix"
        static let myListImage = "myList"
        static let infoImage = "info"
        static let playImage = "play"
    }
    struct Cell {
        static let movie = "MovieCell"
        static let section = "SectionCell"
    }
    enum Sections: Int {
        case trendingMovies = 0
        case trendingTv = 1
        case popular = 2
        case upcoming = 3
        case topRated = 4
    }
}
