//
//  SearchMovie.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 6.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import Foundation

struct SearchMovie: Codable {
    
    var search : [SearchMovieDetails]?
    var totalResults : String?
    var response : ResponseResult?
    
    init(dictionary : [String: Any]) {
        search = dictionary["Search"] as? [SearchMovieDetails]
        totalResults = dictionary["totalResults"] as? String
        response = dictionary["Response"] as? ResponseResult
    }
}

struct Root: Codable{
    var searchMovie: SearchMovie?
}
