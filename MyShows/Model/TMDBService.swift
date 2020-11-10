//
//  TMDBService.swift
//  MyShows
//
//  Created by Levent Bostanci on 02/11/2020.
//

import Foundation

//class MoviesByCategory {
//
//    var name: String
//    var cat: MovieCategory
//    var movies: [Movie]
//
//    init(cat: MovieCategory) {
//        self.cat = cat
//        self.movies = []
//        switch self.cat {
//        case .now_playing: self.name = "A l'affiche"
//        case .upcoming: self.name = "A venir"
//        case .popular: self.name = "Populaire"
//        case .top_rated: self.name = "Mieux notés"
//        }
//    }
//}

final class TMDBService {
    
    // MARK: - Properties
    
    private let httpClient: HTTPClient
    
    // MARK: - Initializer
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    // MARK: - Methods
    
    func getMovie(category: MovieCategory,callback: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(category.rawValue)") else { return }
            let parameters = [("language", "fr"),("api_key", "e6cb2189d29775d655516bccea379b4b")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
    
    func searchMovie(query: String, callback: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie") else { return }
            let parameters = [("api_key", "e6cb2189d29775d655516bccea379b4b"),("language", "fr"), ("query", "")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
                
    }
}
