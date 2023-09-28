//
//  Upcoming.swift
//  MovieAppTests
//
//  Created by Bach Nghiem on 28/09/2023.
//

@testable import MovieApp
import XCTest

final class UpcomingViewControllerTest: XCTestCase {
    var upComingVC: UpcomingViewController!
    
    override func setUpWithError() throws {
        upComingVC = UpcomingViewController()
        upComingVC.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        upComingVC = nil
    }
    
    func testExample() throws {
        let movies = [Movie(adult: false, backdropPath: "", genreIDS: [1,2], id: 1234, originalLanguage: "en", originalTitle: "Barbie", overview: "", popularity: 2.0, posterPath: "", releaseDate: "22-02-2022", title: "Barbie", video: false, voteAverage: 3.0, voteCount: 1000)]
        upComingVC.movies = movies
        upComingVC.viewDidLoad()
        upComingVC.fetchUpcoming()
        upComingVC.viewWillAppear(true)
        upComingVC.viewWillDisappear(true)
        upComingVC.notification(movie: movies[0])
        upComingVC.showError(error: "error")
        XCTAssertEqual(upComingVC.tableView(
            upComingVC.tableView,
            cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, Constant.Cell.comingsoon)
        XCTAssertEqual(
            upComingVC.tableView(upComingVC.tableView,
                                        heightForRowAt: IndexPath(row: 0, section: 0)), Constant.Space.heightOfCell)
        XCTAssertEqual(upComingVC.tableView(upComingVC.tableView, numberOfRowsInSection: 1), movies.count)
    }
}
