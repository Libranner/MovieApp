//
//  Movie.swift
//  MovieApp
//
//  Created by Libranner Leonel Santos Espinal on 10/14/16.
//  Copyright © 2016 libranner. All rights reserved.
//

import UIKit
import Mapper

struct Movie: Mappable {
    let id: Int?
    let title: String?
    let overview: String?
    let popularity: Float?
    let posterPath: String?
    let backdropPath: String?
    
    init(map: Mapper) throws {
        id = map.optionalFrom("id")
        title = map.optionalFrom("title")
        overview = map.optionalFrom("overview")
        popularity = map.optionalFrom("popularity")
        posterPath = map.optionalFrom("poster_path")
        backdropPath = map.optionalFrom("backdrop_path")
    }
    
}
