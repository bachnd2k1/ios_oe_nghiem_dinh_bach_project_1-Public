//
//  ApiCaller.swift
//  MovieApp
//
//  Created by Bach Nghiem on 14/09/2023.
//

import Foundation

enum APIError: Error {
    case failedToGetData
}

final class ApiCaller {
    static let shared = ApiCaller()
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(EndPoint.baseURL)/3/trending/movie/day?api_key=\(Key.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getVideoYoutube(with query: String, completion: @escaping (Result<Youtube,Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(EndPoint.baseYoutubeURL)q=\(query)&key=\(Key.youtubeApiKey)") else { return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch  {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
