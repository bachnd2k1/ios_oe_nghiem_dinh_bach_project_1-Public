//
//  DetailViewControllerTest.swift
//  MovieAppTests
//
//  Created by Bach Nghiem on 28/09/2023.
//

@testable import MovieApp
import XCTest

final class DetailViewControllerTest: XCTestCase {
    var detailVC: DetailViewController!
    
    override func setUpWithError() throws {
        detailVC = DetailViewController()
        detailVC.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        detailVC = nil
    }
    
    func testExample() throws {
        let movie = Movie(adult: false, backdropPath: "", genreIDS: [1,2], id: 1234, originalLanguage: "en", originalTitle: "Barbie", overview: "", popularity: 2.0, posterPath: "", releaseDate: "22-02-2022", title: "Barbie", video: false, voteAverage: 3.0, voteCount: 1000)
        
        detailVC.movie = movie
        detailVC.viewDidLoad()
        detailVC.viewWillAppear(true)
        detailVC.viewWillDisappear(true)
        detailVC.addFavouriteList()
        detailVC.removeFavouriteList()
        detailVC.config(baseURLVideo: "", movie: movie)
        detailVC.getActorList()
        XCTAssertEqual(detailVC.tableView(detailVC.tableView, numberOfRowsInSection: 1), 2)
    }
}
