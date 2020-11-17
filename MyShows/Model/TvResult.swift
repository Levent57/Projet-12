//
//  TvResult.swift
//  MyShows
//
//  Created by Levent Bostanci on 16/11/2020.
//

import Foundation


struct TvResult: Codable {
    
    let page: Int
    let results: [TV]?
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TV: Codable {
    
    let original_name: String?
    let genre_ids: [Int]?
    let name: String?
    let popularity: Double?
    let origin_country: [String]?
    var vote_count: Int?
    let first_air_date: String?
    let backdrop_path: String?
    var original_language: String?
    let id: Int?
    var vote_average: Double
    let overview: String?
    var poster_path: String?
    
    
//    var profile_path: String?
//    let title: String?
//
//
//    let poster: String?
//
//    let release_date: String?
//
//    let video: Bool?
//    var runtime: Int?
//
//
//
//
//
//    //TV
//
//    var birthday: String?
}

//{"page":1,"total_results":10000,"total_pages":500,"results":[{"original_name":"The Mandalorian","genre_ids":[10765,10759,37],"name":"The Mandalorian","popularity":1869.725,"origin_country":["US"],"vote_count":2325,"first_air_date":"2019-11-12","backdrop_path":"\/9ijMGlJKqcslswWUzTEwScm82Gs.jpg","original_language":"en","id":82856,"vote_average":8.5,"overview":"Après les aventures de Jango et Boba Fett, un nouveau héros émerge dans l'univers Star Wars. L'intrigue, située entre la chute de l'Empire et l'émergence du Premier Ordre, suit les voyages d'un chasseur de primes solitaire dans les contrées les plus éloignées de la Galaxie, loin de l’autorité de la Nouvelle République.","poster_path":"\/BbNvKCuEF4SRzFXR16aK6ISFtR.jpg"},{"original_name":"Grey's Anatomy","genre_ids":[18],
