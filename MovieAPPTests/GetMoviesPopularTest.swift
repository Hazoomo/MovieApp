//
//  GetMoviesPopularTest.swift
//  MovieAPPTests
//
//  Created by Hazem Hasan on 5/19/19.
//  Copyright © 2019 24i. All rights reserved.
//

import XCTest
@testable import MovieAPP

class GetMoviesPopularTest: XCTestCase , APIDelegate {

    var moviesClass : ML_MoviesList!
    var exp : XCTestExpectation!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        APICall.shared.delegate = self
        exp = self.expectation(description: "popular movies")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        moviesClass = nil
    }

    func testCallingMoviesPopularServiceWithPositvePage() {
        
       
        
        
        //Test postive number of page
        APICall.shared.getMoviesList(page_number: 10)
        
        
        waitForExpectations(timeout: 25)
        
        
    }
    
    func testCallingMoviesPopularServiceWithNegativePage(){
        
        
        
        //Test postive number of page
        APICall.shared.getMoviesList(page_number: -10)
        
        
        waitForExpectations(timeout: 25)
    }

    //MARK: - APIDelegate
    
    func successAPI(target: MyServerAPI) {
        switch target {
        case .getMoviesList:
            print("Here here")
            self.moviesClass = APICall.shared.movies
            
            
            XCTAssertTrue(self.moviesClass != nil)
        default:
            break
        }
        
        exp.fulfill()
    }
    
    func failureAPI(target: MyServerAPI) {
        
        XCTAssertTrue(self.moviesClass != nil)
        exp.fulfill()
    }

}
