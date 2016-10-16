//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Libranner Leonel Santos Espinal on 10/16/16.
//  Copyright © 2016 libranner. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailViewController: UIViewController {
    var movie : Movie?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwappedMovie = movie else {
            return
        }
        
        titleLabel.text = unwappedMovie.title
        overviewLabel.text = unwappedMovie.overview
        overviewLabel.sizeToFit()
        if movie!.backdropPath != nil {
            let api = MovieAPI.sharedInstance
            let path = api.backdropPath(path: unwappedMovie.backdropPath!)
            backdropImage.setImageWith(path)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
