//
//  NewsFeedViewController.swift
//  GNews
//
//  Created by KEEVIN MITCHELL on 7/23/15.
//  Copyright © 2015 Beyond 2021. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    private struct GnewsConstant {
        static let newsCellIdentifier = "newsCell"
        static let googleNewsString = "http://news.google.com/?output=rss"
        
    }
    // Model
    private var items:[RSSItem] = []
    
    //Interface
    
    @IBOutlet weak var newsTableView: UITableView!
    
    @IBAction func refreshNewsStream(sender: AnyObject) {
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Refresh the data
      //  refreshData()
    }
    // Tuning up the tableview
    func configureTableView() {
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 160.0
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        deselectAllRows()
    }
    
    func deselectAllRows() {
        if let selectedRows = newsTableView.indexPathsForSelectedRows     {
            for indexPath in selectedRows {
                newsTableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    // MARK: Refresh Content
    
    func refreshData() {
        // parseForQuery(searchTextField.text)
    }
    
    
    
}
