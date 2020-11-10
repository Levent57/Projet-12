//
//  Videos.swift
//  MyShows
//
//  Created by Levent Bostanci on 10/11/2020.
//

import Foundation

struct Videos:Codable {
    var id:String?
    var key:String?
    var name:String?
}

struct VideoInfo:Codable {
    var id:Int?
    var results:[Videos]?
}
