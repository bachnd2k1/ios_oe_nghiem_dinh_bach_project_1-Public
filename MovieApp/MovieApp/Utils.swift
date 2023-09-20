//
//  Utils.swift
//  MovieApp
//
//  Created by Bach Nghiem on 18/09/2023.
//

import UIKit
import Foundation

class Utils {
    static func loadImageFromURL(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(nil)
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                completion(image)
            }.resume()
        } else {
            completion(nil)
        }
    }
    
    static func convertToMovie(tvShows: [TVShow]) -> [Movie] {
        let movies = tvShows.map { tvShow in
            return Movie(
                adult: nil,
                backdropPath: nil,
                genreIDS: [],
                id: tvShow.id,
                originalLanguage: nil,
                originalTitle: tvShow.originalTitle,
                overview: tvShow.overview,
                popularity: Constant.Value.zero,
                posterPath: tvShow.posterPath,
                releaseDate: nil,
                title: tvShow.originalName ?? "",
                video: false,
                voteAverage: tvShow.voteAverage ?? Constant.Value.zero,
                voteCount: tvShow.voteCount
            )
        }
        return movies
    }
}
