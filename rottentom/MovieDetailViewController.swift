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
    @IBOutlet weak var movieTitleLabel: UILabel!
    var movie:NSDictionary!
    
    override func loadView() {
        self.view = UIView(frame: CGRectZero)
        //self.view.backgroundColor = UIColor.blackColor()
        //self.view.tintColor = UIColor.whiteColor()
        //self.view.separatorColor = UIColor.darkGrayColor()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        var titleM = movie["title"] as String
        
        println("Movie: + \(titleM)")
        
 //       var movie = movies[0]
 //       movieTitleLabel.text = movie["title"] as? String
 //       movieTitleLabel.text = titleM
        
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
