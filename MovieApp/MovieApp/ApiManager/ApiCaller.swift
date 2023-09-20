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
        let path = EndPoint.baseURL + EndPoint.queryMovie + Key.apiKey
        guard let url = URL(string: path) else { return }
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
    
    func getTrendingTVs(completion: @escaping (Result<[TVShow], Error>) -> Void ) {
        let path = EndPoint.baseURL + EndPoint.queryTvShow + Key.apiKey
        guard let url = URL(string: path) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TVShowResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovie(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let path = EndPoint.baseURL + EndPoint.queryUpComing + Key.apiKey
        guard let url = URL(string: path) else {return}
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
    
    func getPopularMovies(completion: @escaping (Result<[Movie],Error>)-> Void){
        let path = EndPoint.baseURL + EndPoint.queryPopular + Key.apiKey + EndPoint.endPoint
        guard let url = URL(string: path) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else  {
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
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie],Error>)->Void){
        let path = EndPoint.baseURL + EndPoint.queryTopRated + Key.apiKey + EndPoint.endPoint
        guard let url = URL(string :path) else {return}
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
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        let path = EndPoint.baseURL + EndPoint.queryDiscovery + Key.apiKey + EndPoint.endPointDiscovery
        guard let url = URL(string: path) else {return}
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
    
    func getVideoYoutube(with query: String, completion: @escaping (Result<Youtube, Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(EndPoint.baseYoutubeURL)q=\(query)&key=\(Key.youtubeApiKey)") else { return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
