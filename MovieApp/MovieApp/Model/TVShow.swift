//
//  TVShow.swift
//  MovieApp
//
//  Created by Bach Nghiem on 20/09/2023.
//

import Foundation

struct TVShowResponse: Codable {
    let results: [TVShow]
}

struct TVShow: Codable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}
