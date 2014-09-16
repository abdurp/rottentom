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
    @IBOutlet weak var networkErrorLabel: UILabel!
    var movies: [NSDictionary] = []
            var activityView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var HUD = JGProgressHUD(style: JGProgressHUDStyle.Light)
    var refreshControl:UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.addSubview(networkErrorLabel)
        networkErrorLabel.text = "Network Error"
        networkErrorLabel.backgroundColor = UIColor.grayColor()

        networkErrorLabel.hidden = true
    
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        tableView.backgroundColor = UIColor.blackColor()
        tableView.tintColor = UIColor.whiteColor()
        tableView.separatorColor = UIColor.grayColor()

        tableView.delegate = self
        tableView.dataSource = self
        
        getMovies(self)

    }
    
    func getMovies(sender: AnyObject)
    {
        
        HUD.textLabel.text = "Loading.."
        
        HUD.showInView(self.view)
        
        let MyApiKey = "he99jj5xwj7mr2pwsf237nuf"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + MyApiKey
        
            
            let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
                var errorValue: NSError? = nil
                if(error != nil) {
                    println("network error")
                    self.networkErrorLabel.hidden = false
                }
                else{
                    println("hello")
                    self.networkErrorLabel.hidden = true
                    //self.getMovies(self)
                
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary

             //println("dictionary: \(dictionary)")
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()
                }
        })
         //self.movies = [["title" : "abc", "synopsis" : "test1"]] // for testing
        
        HUD.dismiss()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender:AnyObject)
    {
        getMovies(self)
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
 
        var movieRating = movie["mpaa_rating"] as? String
        var movieSyn = movie["synopsis"] as? String

        var finalSyn = movieRating! + " " + movieSyn!
        
        cell.movieSynopsisLabel.textColor = UIColor.whiteColor()
        
        cell.movieSynopsisLabel.text = finalSyn // = movie["synopsis"] as? String

        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        var proUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "pro", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        cell.posterView.setImageWithURL(NSURL(string: proUrl))
        
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
