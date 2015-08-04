//
//  GNewsTests.swift
//  GNewsTests
//
//  Created by KEEVIN MITCHELL on 7/22/15.
//  Copyright © 2015 Beyond 2021. All rights reserved.
//

import XCTest
import Foundation
import GNews
//import GoogleDownloadHelper


class GNewsTests: XCTestCase{
    
    
    override func setUp() {
        super.setUp()
        
            }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatTheNewsFeedViewControllerClassExists(){
        //Check That the news Table view class exists
        let newsVC = NewsFeedViewController()
        XCTAssertNotNil(newsVC,"NewsFeedViewController class exists")

        
    }
    
    func testThatTheCellIdentifierIsCorrect(){
       let basicCellIdentifier = "newsCell"
              XCTAssertEqual(basicCellIdentifier, "newsCell", "The basic cell identifier is newsCell")
        
    }
    
    func testThatTheParserClassExists(){
        let parser = RSSParser()
        XCTAssertNotNil(parser, "Parser object should not be nil")
        
        
    }
    
    func testThatTheParameterIsCorrect(){
        let paramter = ["q": "boost:popular"]
        XCTAssertEqual(paramter, ["q": "boost:popular"], "The parameter is\(paramter) ")
        
    }
   
    func testThatTheGoogleURLIsCorrect(){
        let googleURL = "http://news.google.com/?output=rss"
        XCTAssertEqual(googleURL, "http://news.google.com/?output=rss", "The Google URL  is\(googleURL) ")
        
    }
    
    
    
}
