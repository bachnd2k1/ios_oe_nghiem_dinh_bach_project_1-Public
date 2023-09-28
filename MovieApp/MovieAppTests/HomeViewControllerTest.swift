//
//  HomeViewController.swift
//  MovieAppTests
//
//  Created by Bach Nghiem on 28/09/2023.
//

@testable import MovieApp
import XCTest


final class HomeViewControllerTest: XCTestCase {
    var homeVC: HomeViewController!
    
    override func setUpWithError() throws {
        homeVC = HomeViewController()
        homeVC.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        homeVC = nil
    }
    
    func testExample() throws {
        homeVC.viewDidLoad()
        homeVC.viewWillAppear(true)
        homeVC.viewWillDisappear(true)
        XCTAssertEqual(homeVC.tableView(
            homeVC.tableView,
            cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, Constant.Cell.section)
    }
}
