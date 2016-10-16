//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Libranner Leonel Santos Espinal on 10/14/16.
//  Copyright © 2016 libranner. All rights reserved.
//

import UIKit
import MBProgressHUD

class MovieAPI: NSObject {
    static let sharedInstance = MovieAPI()
    fileprivate let httpClient: HTTPClient

    override init() {
        httpClient = HTTPClient()
        print("Movie API initialized")
        super.init()
    }
    //afterRequestBlock: (_ result: [AnyObject], _ error: Error) -> Void
    
    func getCurrentMovies(afterRequestBlock: @escaping (_ result: [Movie]?, _ error:Error?) -> Void){
        httpClient.getMovies(completionBlock: {(result: NSDictionary, error:Error?) in
            let json = result.object(forKey: "results") as! NSArray?
            guard let unwrappedJson = json else{
                afterRequestBlock(nil, error)
                return
            }
            let movies = Movie.from(unwrappedJson)
            afterRequestBlock(movies, error)
        })
    }
    
    func posterPath(path: String) -> URL{
        return httpClient.posterPath(path: path)
    }
    
    func backdropPath(path: String) -> URL{
        return httpClient.backdropPath(path: path)
    }
    
    func getMovie(id: Int, afterRequestBlock: @escaping (_ result: Movie?, _ error:Error?) -> Void){
        httpClient.getMovie(id: id, completionBlock: {(result: NSDictionary, error:Error?) in
            let json = result.object(forKey: "results") as! NSArray
            guard let unwrappedMovies = Movie.from(json) else{
                afterRequestBlock(nil, error)
                return
            }
            
            if(unwrappedMovies.count > 0){
                let movie = unwrappedMovies.first!
                afterRequestBlock(movie, error)
            }
        })
    }
    
}
