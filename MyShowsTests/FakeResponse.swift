//
//  FakeResponse.swift
//  MyShowsTests
//
//  Created by Levent Bostanci on 21/11/2020.
//

import Foundation

class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Movie", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let incorrectData = "error".data(using: .utf8)
}
