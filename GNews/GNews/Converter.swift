//
//  Converter.swift
//  GNews
//
//  Created by KEEVIN MITCHELL on 7/28/15.
//  Copyright © 2015 Beyond 2021. All rights reserved.
//

import Foundation

struct Convert {
   // private var resultsArray = [RSSItem]()
    
    
    func ItemPropertiesToPlainText(rssItems:[RSSItem]){
        for item in rssItems {
            let charSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
            
            if let title = item.title as NSString! {
                item.title = title.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }
            
            if let mediaDescription = item.mediaDescription as NSString! {
                item.mediaDescription = mediaDescription.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }
            
            if let itemDescription = item.itemDescription as NSString! {
                item.itemDescription = itemDescription.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }
            
            
            if let mediaText = item.mediaText as NSString! {
                item.mediaText = mediaText.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }
        }
        
        
    }
}
