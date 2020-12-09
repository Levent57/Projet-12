//
//  MovieService.swift
//  MyShows
//
//  Created by Levent Bostanci on 21/10/2020.
//

import Foundation

enum MovieCategory: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
}

enum TvShowCategory: String, CaseIterable {
    case popular
    case onTheAir = "on_the_air"
    case topRated = "top_rated"
}

enum SelectedCategory: String {
    case search = "search/movie/"
    case movie = "movie/"
    case trendingTV = "tv/"
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

    //call for movies
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
    
    //call for tv shows
    func getTvShows(category: TvShowCategory, selection: SelectedCategory, callback: @escaping (Bool, [TV]?) -> Void) {
        guard let url = URL(string: baseUrl + selection.rawValue + category.rawValue +  lang + key) else { return }
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
                guard let responseJSON = try? JSONDecoder().decode(TvResult.self, from: data),
                      let translatedMovie = responseJSON.results else {
                    callback(false, nil)
                    return
                }
                callback(true, translatedMovie)
            }
        }
        task?.resume()
    }

    //call for searching movies
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
    
    //call for download videos trailers
    func getDataRequest(url:String, onCompletion:@escaping (Data)->()){
        let path = "https://api.themoviedb.org/3\(url)"
        if let url = URL(string: path) {
            print(url)
                movieSession.dataTask(with: url) {
                (data, response,error) in
                
                guard let data = data, error == nil, response != nil else{
                    print("Something is wrong: \(String(describing: error?.localizedDescription))")
                    return
                }
                onCompletion(data)
                }.resume()
        }
        else {
            print("Unable to create URL")
        }
    }
    
    //movies trailers
    func movieVideos(movieID:Int, completion: @escaping (VideoInfo)->()) {
        let getURL = "/movie/\(movieID)/videos?api_key=e6cb2189d29775d655516bccea379b4b&language=en-US"
        getDataRequest(url: getURL) { jsonData in
            do
            {
                let results = try JSONDecoder().decode(VideoInfo.self, from: jsonData)
                completion(results)
            }
            catch
            {
                print("JSON Downloading Error!")
            }
        }
    }
    
    //tv shows trailers
    func tvVideos(tvID:Int, completion: @escaping (VideoInfo)->()) {
        let getURL = "/tv/\(tvID)/videos?api_key=e6cb2189d29775d655516bccea379b4b&language=en-US"
        getDataRequest(url: getURL) { jsonData in
            do
            {
                let results = try JSONDecoder().decode(VideoInfo.self, from: jsonData)
                completion(results)
            }
            catch
            {
                print("JSON Downloading Error!")
            }
        }
    }
    
    //youtube image url
    func youtubeThumb(path:String)->URL?{
       if let url = URL(string: "https://img.youtube.com/vi/" + path + "/0.jpg"){
           return url
       }
       return nil
   }
   
    //youtube video url
    func youtubeURL(path:String)->URL?{
       if let url = URL(string: "https://www.youtube.com/watch?v=" + path){
        print(url)
           return url
       }
       return nil
   }
    
}
