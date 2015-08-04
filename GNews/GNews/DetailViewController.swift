//
//  DetailViewController.swift
//  GNews
//
//  Created by KEEVIN MITCHELL on 8/4/15.
//  Copyright © 2015 Beyond 2021. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: RSSItem? = nil
    
    @IBOutlet weak var subtitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageViewImage()
        setTitleLabelText()
        setSubtitleLabelText()
    }
    
    func setImageViewImage() {
        
        if imageView == nil {
            return
        }
        
        let url = firstMediaContentImageURL()
        if url == nil {
            return
        }
        
        let request = NSURLRequest(URL: url!)
        
        self.activityIndicator.startAnimating()
        
        imageView!.setImageWithURLRequest(request, placeholderImage: nil,
            
            success: { (request, response, image) -> Void in
                self.activityIndicator.stopAnimating()
                self.imageView!.image = image
                
            }, failure: { (url, response, error) -> Void in
                self.activityIndicator.stopAnimating()
                self.imageView!.image = nil
        });
    }
    
    func firstMediaContentImageURL() -> NSURL? {
        for mediaContent in item?.mediaContents as! [RSSMediaContent] {
            if mediaContent.url != nil {
                return mediaContent.url
            }
        }
        return nil
    }
    
    func setTitleLabelText() {
        
        var title = item?.title
        
        if title == nil || (title!).characters.count == 0 {
            title = NSLocalizedString("[No Title]", comment: "")
        }
        
        titleLabel.text = title
    }
    
    func setSubtitleLabelText() {
        
        if let mediaText = item?.itemDescription {
            subtitleLabel.text = mediaText
            
        } else if let mediaDescription = item?.mediaDescription {
            subtitleLabel.text = mediaDescription
            
        } else {
            subtitleLabel.text = ""
        }
    }
}
