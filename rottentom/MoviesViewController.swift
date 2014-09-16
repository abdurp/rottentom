//
//  MoviesViewController.swift
//  rottentom
//
//  Created by admin on 9/13/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary] = []
            var activityView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var HUD = JGProgressHUD(style: JGProgressHUDStyle.Light)
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        HUD.textLabel.text = "Loading.."
        
        HUD.showInView(self.view)
        
        HUD.dismissAfterDelay(2.0)
        
        let networkMon = AFNetworkReachabilityManager.sharedManager()
        
        networkMon.startMonitoring()
        
        networkMon.setReachabilityStatusChangeBlock {(status: AFNetworkReachabilityStatus?) in
            switch status!.hashValue {
            case AFNetworkReachabilityStatus.NotReachable.hashValue:
                println("Network Error")
            case AFNetworkReachabilityStatus.ReachableViaWiFi.hashValue:
                println("Reachable via Wi-Fi")
            default:
                println("Reachable via LAN")
            }
        }
        
        //activityView.center = self.view.center
        
        //activityView.startAnimating()
        
        //self.view.addSubview(activityView)
        
        
        tableView.backgroundColor = UIColor.blackColor()
        tableView.tintColor = UIColor.whiteColor()
        tableView.separatorColor = UIColor.grayColor()

        tableView.delegate = self
        tableView.dataSource = self

        let MyApiKey = "he99jj5xwj7mr2pwsf237nuf"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + MyApiKey
        
        //let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        
        //NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
         //   var errorValue: NSError? = nil
        //    let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
        
            
            let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
                var errorValue: NSError? = nil
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
           
             //println("dictionary: \(dictionary)")
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()

        })
        // self.movies = [["title" : "abc", "synopsis" : "test1"]] // for testing
        
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //activityView.stopAnimating()
        //HUD.dismiss()
        
        println("I'm at row: \(indexPath.row), section: \(indexPath.section)")
        

        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        cell.backgroundColor = UIColor.blackColor()
        cell.tintColor = UIColor.whiteColor()
        
        var movie = movies[indexPath.row]
        println("\(indexPath.row)")

        cell.movieTitleLabel.textColor = UIColor.whiteColor()
        
        cell.movieTitleLabel.text = movie["title"] as? String
        
        cell.movieSynopsisLabel.textColor = UIColor.whiteColor()
        cell.movieSynopsisLabel.text = movie["synopsis"] as? String

        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        
        cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        
        return cell
    }
    
//   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let detailsViewController = MovieDetailViewController(nibName: nil, bundle: nil)
//        detailsViewController.movie = movies[indexPath.row]
//        self.navigationController?.pushViewController(detailsViewController, animated: true)
    
   // }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        
        let movieDetailViewController = segue.destinationViewController as MovieDetailViewController
        var row = self.tableView.indexPathForSelectedRow()?.row
        movieDetailViewController.movie = movies[row!]
        if let movieCell = sender as? MovieCell {
            movieDetailViewController.navigationItem.title = movieCell.movieTitleLabel.text
            
            
            
        }
        
    

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
