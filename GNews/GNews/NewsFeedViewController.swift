//
//  NewsFeedViewController.swift
//  GNews
//
//  Created by KEEVIN MITCHELL on 7/23/15.
//  Copyright © 2015 Beyond 2021. All rights reserved.
//

import UIKit
import CoreData // For persistance


class NewsFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Constants
    let newsCellIdentifier = "newsCell"
    let googleNewsString = "http://news.google.com/?output=rss"
    let parser = RSSParser()
    let parameter = ["q": "boost:popular"]
    
    //Outlet Connections
    
    @IBOutlet weak var newsTableView: UITableView!
    
    //Outlet Actions
    @IBOutlet weak var refreshAction: UIBarButtonItem!
    
    //MARK: Our simple model array or items before coredata
    //    var items:[RSSItem] = []
    
    //Persistence
    var items = [NSManagedObject]()
    
    
    
    //Network Call
    func parseForQuery() {
        //        showProgressHUD()
        
        parser.parseRSSFeed(googleNewsString,
            parameters: parameter ,
            success: {(let channel: RSSChannel!) -> Void  in
                
                //  print("The channel is : \(channel)")
                
                self.convertItemPropertiesToPlainText(channel.items as! [RSSItem])
                // self.items = (channel.items as! [RSSItem])
                let returnedItems = (channel.items as! [RSSItem])
                self.persistData(returnedItems)
                
                
                self.hideProgressHUD()
                self.reloadTableViewContent()
                
            }, failure: {(let error:NSError!) -> Void in
                
                self.hideProgressHUD()
                print("Error: \(error)")
        })
    }
    
    
    // MARK : View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        configureTableView()
        refreshData()
    }
    
    //Dynamic row size for the tableView
    func configureTableView() {
        // TODO: Write this...
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 160.0
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        deselectAllRows()
    }
    
    //Deselect the selected rows
    func deselectAllRows() {
        if let selectedRows = newsTableView.indexPathsForSelectedRows     {
            for indexPath in selectedRows {
                newsTableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    //Refresh the data
    @IBAction func refreshAxtion(sender: AnyObject) {
        parseForQuery()
    }
    
    func refreshData() {
        parseForQuery()
        
    }
    
    func persistData(objectsTosave:[RSSItem]){
        
        let articles = objectsTosave
        
        
        for article in articles {
            //1
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            //2
            let entity =  NSEntityDescription.entityForName("NewsArticle",
                inManagedObjectContext:
                managedContext)
            
            let news = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext:managedContext)
            
            //3
            news.setValue(article.title, forKey: "title")
            news.setValue(article.itemDescription, forKey: "itemDescription")
            // news.setValue(article.mediaThumbnails, forKey: "thumbnailImage")
            
            //4
            if managedContext.hasChanges {
                do {
                    try managedContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
            //5
            self.items.append(news)
            
        }
        
    }
    
    
    
    //MARK: //Progressive Hud
    
    //The function to show the loading progress view
    func showProgressHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
    }
    
    //The function to hide the loading progress view
    func hideProgressHUD() {
        MBProgressHUD.hideAllHUDsForView(view, animated: true)
    }
    
    
    //MARK: RSSItem Converter
    //Here we convert the returning xml feed tp plain text
    
    func convertItemPropertiesToPlainText(rssItems:[RSSItem]) {
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
    
    func reloadTableViewContent() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.newsTableView.reloadData()
            self.newsTableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
        })
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if hasImageAtIndexPath(indexPath) {
            return imageCellAtIndexPath(indexPath)
            
        } else {
            return basicCellAtIndexPath(indexPath)
        }
    }
    
    func hasImageAtIndexPath(indexPath:NSIndexPath) -> Bool {
        // let item = items[indexPath.row]
        //TODO
        return false
    }
    
    func imageCellAtIndexPath(indexPath:NSIndexPath) -> ImageCell {
        let cell = self.newsTableView.dequeueReusableCellWithIdentifier(newsCellIdentifier) as! ImageCell
        setImageForCell(cell, indexPath: indexPath)
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setImageForCell(cell:ImageCell, indexPath:NSIndexPath) {
        //TODO
    }
    
    
    
    
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> NewsCell {
        var cell = newsTableView.dequeueReusableCellWithIdentifier(newsCellIdentifier) as? NewsCell
        if cell == nil {
            cell = NewsCell(style: UITableViewCellStyle.Value1, reuseIdentifier: newsCellIdentifier)
        }
        setTitleForCell(cell!, indexPath: indexPath)
        setSubtitleForCell(cell!, indexPath: indexPath)
        return cell!
    }
    
    
    
    
    
    
    
    func setTitleForCell(cell:NewsCell, indexPath:NSIndexPath) {
        let newsArticle = items[indexPath.row]
        cell.titleLabel.text = newsArticle.valueForKey("title") as? String ?? "[No Title]"
    }
    
    func setSubtitleForCell(cell:NewsCell, indexPath:NSIndexPath) {
        //let item = items[indexPath.row] as RSSItem
        let newsArticle = items[indexPath.row] as NSManagedObject
        
        
        /// let subtitle: NSString? = item.mediaText ?? item.mediaDescription
        //   let subtitle: NSString? = item.itemDescription
        let subtitle: NSString? = newsArticle.valueForKey("itemDescription") as? String ?? "[No Title]"
        if let subtitle = subtitle {
            // Some subtitles are really long, so only display the first 200 characters
            if subtitle.length > 200 {
                cell.subtitleLabel.text = "\(subtitle.substringToIndex(200))..."
                
            } else {
                cell.subtitleLabel.text = subtitle as String
            }
            
        } else {
            cell.subtitleLabel.text = ""
        }
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = newsTableView.indexPathForSelectedRow
        let item = items[indexPath!.row] as NSManagedObject
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.item = item
    }
    
    
    
}
