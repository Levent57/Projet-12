//
//  MyShowsTests.swift
//  MyShowsTests
//
//  Created by Levent Bostanci on 21/11/2020.
//

import XCTest
@testable import MyShows

class MyShowsTests: XCTestCase {
    
    func testGetMovieShouldPostFailedCallbackIfError() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getMovie(category: .popular, selection: .movie) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetMovieShouldPostFailedCallbackIfIncorrectResponse() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getMovie(category: .nowPlaying, selection: .movie) { (success, results) in

            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetMovieShouldPostFailedCallbackIfIncorrectData() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getMovie(category: .nowPlaying, selection: .movie) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMovieShouldPostSuccessCallbackIfCorrectDataAndNoError() {
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getMovie(category: .nowPlaying, selection: .movie) { (success, results) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGetTvShowsShouldPostFailedCallbackIfError() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getTvShows(category: .onTheAir, selection: .trendingTV) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTvShowsShouldPostFailedCallbackIfIncorrectResponse() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getTvShows(category: .onTheAir, selection: .trendingTV) { (success, results) in

            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTvShowsShouldPostFailedCallbackIfIncorrectData() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getTvShows(category: .onTheAir, selection: .trendingTV) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTvShowsShouldPostSuccessCallbackIfCorrectDataAndNoError() {
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.getTvShows(category: .onTheAir, selection: .trendingTV) { (success, results) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetSearchShouldPostFailedCallbackIfError() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.searchMovie(selection: .movie, query: []) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetSearchShouldPostFailedCallbackIfIncorrectResponse() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.searchMovie(selection: .movie, query: []) { (success, results) in

            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetSearchShouldPostFailedCallbackIfIncorrectData() {
        
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.searchMovie(selection: .movie, query: []) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSearchShouldPostSuccessCallbackIfCorrectDataAndNoError() {
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.searchMovie(selection: .movie, query: []) { (success, results) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetServiceTVShouldPostFailedCallbackIfCorrectDataAndNoError() {

        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        movieService.tvVideos(tvID: 82856) { (results) in
            XCTAssertNotNil(results)
            expectation.fulfill()
            }

        wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetServiceMovieShouldPostFailedCallbackIfCorrectDataAndNoError() {

        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Unable to create URL")
        movieService.movieVideos(movieID: 577922) { (results) in
            XCTAssertNil(results)
            expectation.fulfill()
            }

        wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetYoutubeURLShouldPostSuccessCallBackIfCorrectDataAndNoError() {
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        let ytb = movieService.youtubeURL(path: "ywhTeWg8970")
        XCTAssertEqual(ytb, URL(string: "https://www.youtube.com/watch?v=ywhTeWg8970"))
    }
    
    func testGetYoutubeImageShouldPostSuccessCallBackIfCorrectDataAndNoError() {
        let movieService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        let ytb = movieService.youtubeThumb(path: "LdOM0x0XDMo")
        XCTAssertEqual(ytb, URL(string: "https://img.youtube.com/vi/LdOM0x0XDMo/0.jpg"))
    }

}
