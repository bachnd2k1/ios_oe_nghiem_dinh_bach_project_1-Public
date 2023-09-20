//
//  EndPoint.swift
//  MovieApp
//
//  Created by Bach Nghiem on 14/09/2023.
//

import Foundation

struct EndPoint {
    static let baseURL = "https://api.themoviedb.org"
    static let baseURLImage = "https://image.tmdb.org/t/p/w500"
    static let baseYoutubeURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let queryMovie = "/3/trending/movie/day?api_key="
    static let queryTvShow = "/3/trending/tv/day?api_key="
    static let queryUpComing = "/3/movie/upcoming?api_key="
    static let queryPopular = "/3/movie/popular?api_key="
    static let queryTopRated = "/3/movie/top_rated?api_key="
    static let queryDiscovery = "/3/discover/movie?api_key="
    static let endPoint = "&language=en-US&page=1"
    static let endPointDiscovery = "&language=en-US"
                                    + "&sort_by=popularity.desc"
                                    + "&include_adult=false"
                                    + "&include_video=false"
                                    + "&page=1"
                                    + "&with_watch_monetization_types=flatrate"
}
