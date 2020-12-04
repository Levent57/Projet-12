//
//  MyShowsTests.swift
//  MyShowsTests
//
//  Created by Levent Bostanci on 21/11/2020.
//

import XCTest
@testable import MyShows

class MyShowsTests: XCTestCase {
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getMovie(category: .popular, selection: .movie) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getMovie(category: .now_playing, selection: .movie) { (success, results) in

            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getMovie(category: .now_playing, selection: .movie) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    
    func testGetTranslationShouldPostFailedCallbackIfNoData2() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTvShows(category: .on_the_air, selection: .trendingTV) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse2() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTvShows(category: .on_the_air, selection: .trendingTV) { (success, results) in

            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData2() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTvShows(category: .on_the_air, selection: .trendingTV) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    
    

    func testGetTranslationShouldPostFailedCallbackIfNoData3() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.searchMovie(selection: .movie, query: []) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse3() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.searchMovie(selection: .movie, query: []) { (success, results) in

            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData3() {
        
        let translationService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.searchMovie(selection: .movie, query: []) { (success, results) in
            
            XCTAssertFalse(success)
            XCTAssertNil(results)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData4() {

        let translationService = MovieService(movieSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.tvVideos(tvID: 82856) { (results) in
            XCTAssertNil(results)
            expectation.fulfill()
            }

        wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData5() {

        let translationService = MovieService(movieSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.movieVideos(movieID: 577922) { (results) in
            XCTAssertNil(results)
            expectation.fulfill()
            }

        wait(for: [expectation], timeout: 0.01)
        }

}
