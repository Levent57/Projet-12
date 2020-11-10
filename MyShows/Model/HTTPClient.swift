//
//  HTTPClient.swift
//  MyShows
//
//  Created by Levent Bostanci on 02/11/2020.
//

import Foundation

final class HTTPClient {

    // MARK: - Properties

    private let httpEngine: HTTPEngine

    // MARK: - Initializer

    init(httpEngine: HTTPEngine = HTTPEngine()) {
        self.httpEngine = httpEngine
    }

    func request<T: Decodable>(baseUrl: URL, parameters: [(String, Any)]?, callback: @escaping (Result<T, NetworkError>) -> Void) {
        httpEngine.request(baseUrl: baseUrl, parameters: parameters) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            guard let response = response, response.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}
