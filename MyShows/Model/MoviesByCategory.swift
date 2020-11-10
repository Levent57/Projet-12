//
//  MoviesByCategory.swift
//  MyShows
//
//  Created by Levent Bostanci on 23/10/2020.
//

import Foundation

class MoviesByCategory {
    
    var name: String
    var cat: MovieCategory
    var movies: [Movie]
    var tvShows: [Movie]
    
    init(cat: MovieCategory) {
        self.cat = cat
        self.movies = []
        self.tvShows = []
        switch self.cat {
        case .now_playing: self.name = "A l'affiche"
        case .upcoming: self.name = "A venir"
        case .popular: self.name = "Populaire"
        case .top_rated: self.name = "Mieux notés"
        }
    }
}

