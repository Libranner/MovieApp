//
//  HTTPClient.swift
//  MovieApp
//
//  Created by Libranner Leonel Santos Espinal on 10/14/16.
//  Copyright © 2016 libranner. All rights reserved.
//

import UIKit

class HTTPClient: NSObject {
    public typealias CompletionBlock = (_ result: NSDictionary, _ error:Error?) -> Void
    let nowPlayingBaseURL = "https://api.themoviedb.org/3/movie/now_playing"
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let posterURL = "http://image.tmdb.org/t/p/w185/"
    let backdropURL = "http://image.tmdb.org/t/p/w780/"
    
    fileprivate func getNowPlayingMoviesURL() -> URL {
        return URL(string:"\(nowPlayingBaseURL)?api_key=\(apiKey)")!
    }
    
    fileprivate func getMovieURL(_ id: Int) -> URL{
        return URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)")!
    }
    
    func posterPath(path: String) -> URL{
        return URL(string: "\(posterURL)\(path)?api_key=\(apiKey)")!
    }
    
    func backdropPath(path: String) -> URL{
        return URL(string: "\(backdropURL)\(path)?api_key=\(apiKey)")!
    }
    
    func getMovies(completionBlock: @escaping CompletionBlock){
        getRequest(url: getNowPlayingMoviesURL(), completionBlock: completionBlock)
    }
    
    func getMovie(id: Int, completionBlock: @escaping CompletionBlock){
        getRequest(url: getMovieURL(id), completionBlock: completionBlock)
    }
    
    func dataToJSON (_ data: Data?) -> NSDictionary {
        guard let unwrappedData: Data =  data else{
            return NSDictionary()
        }
        
        if let responseDictionary = try! JSONSerialization.jsonObject(with: unwrappedData, options:[]) as? NSDictionary {
            //NSLog("response: \(responseDictionary)")
            return responseDictionary
        }
        else{
            return NSDictionary()
        }
    }
    
    fileprivate func getRequest(url: URL, completionBlock: @escaping CompletionBlock) {
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil, delegateQueue: OperationQueue.main)
        
        let task : URLSessionDataTask = session.dataTask(with: request) { (dataOrNil, response, error) in
            completionBlock(self.dataToJSON(dataOrNil), error)
        }
        
        task.resume()
    }
}
