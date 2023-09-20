//
//  Youtube.swift
//  MovieApp
//
//  Created by Bach Nghiem on 14/09/2023.
//

import Foundation

struct Youtube: Codable {
    let id : VideoElement
}

struct YoutubeResponse : Codable {
    let items : [Youtube]
}

struct VideoElement : Codable {
    let kind : String
    let videoId : String
}
