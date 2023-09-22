//
//  Constant.swift
//  MovieApp
//
//  Created by Bach Nghiem on 18/09/2023.
//

import UIKit
import Foundation

class Constant {
    struct ViewController {
        static let HOME = HomeViewController()
        static let UPCOMING = UpcomingViewController()
        static let FAVOURITE = FavouriteViewController()
        static let SEARCH = SearchViewController()
    }
    struct Title {
        static let HOME = "Home"
        static let UPCOMING = "Upcoming"
        static let FAVOURITE = "Favourite"
        static let SEARCH = "Search"
    }
    struct Value {
        static let zero = 0.0
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
        static let heightOfCell = 370.0
        static let heightOfCollectionResult = 200.0
        static let widthOfCollectionResult = UIScreen.main.bounds.width / 3 - 10
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
        static let comingsoon = "ComingSoonCell"
        static let header = "HeaderCell"
        static let table = "TableViewCell"
        static let search = "SearchCell"
        static let topSearch = "TopSearchCell"
    }
    enum Sections: Int {
        case trendingMovies = 0
        case trendingTv = 1
        case popular = 2
        case upcoming = 3
        case topRated = 4
    }
}
