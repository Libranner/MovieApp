//
//  ViewController.swift
//  MovieApp
//
//  Created by Libranner Leonel Santos Espinal on 10/14/16.
//  Copyright © 2016 libranner. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status: AFNetworkReachabilityStatus) -> Void in
            switch status {
            case .notReachable:
                print("Not Reachable")
                self.errorView.isHidden = false
            case .reachableViaWiFi, .reachableViaWWAN:
                self.errorView.isHidden = true
                print("Reachable")
            case .unknown:
                print("Unknown")
            }
            
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
        loadData(refreshControl)
    }
    
    func loadData(_ refreshControl: UIRefreshControl){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        MovieAPI.sharedInstance.getCurrentMovies { (movies, error) in
            self.movies = movies!
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    //Tableview Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.overviewLabel.sizeToFit()
       
        if movie.posterPath != nil {
             let api = MovieAPI.sharedInstance
            let path = api.posterPath(path: movie.posterPath!)
            cell.posterImage.setImageWith(path)
        }
       
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail"){
            let destination = segue.destination as! MovieDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            destination.movie = movies[indexPath.row]
        }
    }
}

