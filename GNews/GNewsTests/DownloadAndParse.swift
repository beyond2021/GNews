//
//  DownloadAndParse.swift
//  GNews
//
//  Created by KEEVIN MITCHELL on 8/2/15.
//  Copyright © 2015 Beyond 2021. All rights reserved.
//

import XCTest
import GNews
import AVFoundation

class DownloadAndParse: XCTestCase {
    
    
    func testAsynchronousURLConnection() {
        let URL = NSURL(string: "http://news.google.com/?output=rss")!
        let expectation = expectationWithDescription("GET \(URL)")
        let URLString = "http://news.google.com/?output=rss"
        let parameter = ["q": "boost:popular"]
        let parser = RSSParser()
        parser.parseRSSFeed(URLString,
            parameters:parameter ,
            success:{(let channel: RSSChannel!) -> Void  in
                
                XCTAssertNotNil(channel, "data should not be nil")
                let media = RSSMediaContent()
                
                if let HTTPResponse = channel ,
                    responseURL = HTTPResponse.link,
                    MIMEType = media.type
                    
                {
                    XCTAssertNotEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
                    
                    XCTAssertEqual(MIMEType, "text/html", "HTTP response content type should be text/html")
                } else {
                    XCTFail("Response was not NSHTTPURLResponse")
                }
                XCTFail("Response was not NSHTTPURLResponse")
                
                
        }, failure:
            {(let error:NSError!) -> Void in
                XCTAssertNil(error, "error should be nil")
                XCTFail("error should be nil")
                
                
        })
 
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(URL) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            
            expectation.fulfill()
        }
        
        task!.resume()
        
        waitForExpectationsWithTimeout(task!.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task!.cancel()
        }
    }
    
    func testParseForQuery()(var retry : Bool ,
        var failure fail : (NSError -> ())? ,
        var success succeed: (RSSChannel! -> ())? ) {
            
            retry = true
            fail = nil
            succeed = nil
            
           }
    
    
    
    
//    // Default success
//    parseForQuery(failure: { error in
//    // Failure
//    })
//    
//    // Default failure
//    parseForQuery { void in
//    // Success
//    }
//    
//    // Default failure and success
//    parseForQuery()
    
    //func parseForQuery(failure fail : (NSError -> ())? = nil, success succeed: (RSSChannel! -> ())? = nil)
    
    
    
    
    
}
