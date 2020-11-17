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
    
    init(cat: MovieCategory) {
        self.cat = cat
        self.movies = []
        switch self.cat {
        case .now_playing: self.name = "A l'affiche"
        case .upcoming: self.name = "A venir"
        case .popular: self.name = "Populaire"
        case .top_rated: self.name = "Mieux notés"
        }
    }
}

class TvShowsByCategory {
    var name: String
    var tvCat: TvShowCategory
    var tvShows: [TV]
    
    init(tvCat: TvShowCategory) {
        self.tvCat = tvCat
        self.tvShows = []
        switch self.tvCat {
        case .on_the_air: self.name = "Actuellement"
        case .popular: self.name = "Populaire"
        case .top_rated: self.name = "Mieux notés"
        }
    }
}

