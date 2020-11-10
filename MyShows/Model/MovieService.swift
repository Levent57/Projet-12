//
//  MovieService.swift
//  MyShows
//
//  Created by Levent Bostanci on 21/10/2020.
//

import Foundation

enum MovieCategory: String, CaseIterable {
    case now_playing
    case upcoming
    case top_rated
    case popular
}

enum SelectedCategory: String {
    case search = "search/movie/"
    case movie = "movie/"
    case trendingTV = "trending/tv/week"
}

class MovieService {

    private let key = "&api_key=e6cb2189d29775d655516bccea379b4b"
    private let baseUrl = "https://api.themoviedb.org/3/"
    private let lang = "?language=fr"
    private let search = "&query="
    static let youtubeThumb = "https://img.youtube.com/vi/"
    static let youtubeLink = "https://www.youtube.com/watch?v="

    init(movieSession: URLSession = URLSession(configuration: .default)) {
        self.movieSession = movieSession
    }

    private var movieSession: URLSession

    func getMovie(category: MovieCategory,selection: SelectedCategory, callback: @escaping (Bool, [Movie]?) -> Void) {
        guard let url = URL(string: baseUrl + selection.rawValue + category.rawValue + lang + key) else { return }
        print(url)
        var task: URLSessionDataTask?
        task?.cancel()
        task = movieSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(MovieResult.self, from: data),
                      let translatedMovie = responseJSON.results else {
                    callback(false, nil)
                    return
                }
                callback(true, translatedMovie)
            }
        }
        task?.resume()
    }
    
    func getTvShows(selection: SelectedCategory, callback: @escaping (Bool, [Movie]?) -> Void) {
        guard let url = URL(string: baseUrl + selection.rawValue +  lang + key) else { return }
        print(url)
        var task: URLSessionDataTask?
        task?.cancel()
        task = movieSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(MovieResult.self, from: data),
                      let translatedMovie = responseJSON.results else {
                    callback(false, nil)
                    return
                }
                callback(true, translatedMovie)
            }
        }
        task?.resume()
    }

    func searchMovie(selection: SelectedCategory,query: [String], callback: @escaping (Bool, [Movie]?) -> Void) {
        guard let url = URL(string: baseUrl + selection.rawValue + lang + key + search + query.joined()) else { return }
        var task:URLSessionDataTask?
        task?.cancel()
        task = movieSession.dataTask(with: url) { (data, response, error) in
            print(url)
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(MovieResult.self, from: data),
                      let searchMovie = responseJSON.results else {
                    print("There was an error with searching: \(String(describing: error?.localizedDescription))")
                    callback(false, nil)
                    return
                }
                callback(true, searchMovie)
            }
        }
        task?.resume()
    }
}
