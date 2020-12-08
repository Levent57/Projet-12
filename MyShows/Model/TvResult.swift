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
}
