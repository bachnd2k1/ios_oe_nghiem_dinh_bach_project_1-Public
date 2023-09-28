//
//  FavouriteViewControllerTest.swift
//  MovieAppTests
//
//  Created by Bach Nghiem on 28/09/2023.
//

import XCTest
@testable import MovieApp

final class FavouriteViewControllerTest: XCTestCase {
    var favoriteVC: FavouriteViewController!
    override func setUpWithError() throws {
        favoriteVC = FavouriteViewController()
        favoriteVC.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        favoriteVC = nil
    }
    
    func testExample() throws {
        let coreData = favoriteVC.coreDataRepo
        let myListArray = coreData.getAll()
        favoriteVC.viewDidLoad()
        favoriteVC.viewWillAppear(true)
        favoriteVC.viewWillDisappear(true)
        favoriteVC.tableView.reloadData()
        favoriteVC.config()
        favoriteVC.fetchDataFromCoreData()
        favoriteVC.myListArray = myListArray
        XCTAssertEqual(favoriteVC.tableView(favoriteVC.tableView,
                                            cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, Constant.Cell.favourite)
        XCTAssertEqual(favoriteVC.tableView(favoriteVC.tableView, numberOfRowsInSection: 1), myListArray.count)
    }
}
