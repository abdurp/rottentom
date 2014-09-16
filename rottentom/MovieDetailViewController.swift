//
//  MovieDetailViewController.swift
//  rottentom
//
//  Created by admin on 9/14/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsScrollView: UIScrollView!

    var movie:NSDictionary!
    
//    override func loadView() {
//        self.view = UIView(frame: CGRectZero)
//        //self.view.backgroundColor = UIColor.blackColor()
//        //self.view.tintColor = UIColor.whiteColor()
//        //self.view.separatorColor = UIColor.darkGrayColor()
//        self.view.backgroundColor = UIColor.whiteColor()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        self.detailsScrollView.addSubview(detailsView)

        var mTitle = movie["title"] as? String
        
        println("Movie: \(mTitle)")
        
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        var originalUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        self.posterView.setImageWithURL(NSURL(string: originalUrl))

        
        
        var mYear = String(movie["year"] as NSInteger)
        
        var mRating = movie["mpaa_rating"] as? String
        
        var mSyn = movie["synopsis"] as? String
        
        var finalDetails = mTitle! + " (" + mYear + ")" + "\n" + mRating! + "\n\n" + mSyn!
        
        self.detailsLabel.text = finalDetails

        self.detailsScrollView.scrollEnabled = true
        
        self.detailsScrollView.contentSize = CGSize(width: 320, height: detailsLabel.frame.size.height + detailsLabel.frame.origin.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
