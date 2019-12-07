//
//  SearchMovieDetails.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 6.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import Foundation

struct SearchMovieDetails: Codable {
    var title: String?
    var year: String?
    var imdbID: String?
    var type: String?
    var poster : String?
    
    init(dictionary : [String: Any] ) {
        title = dictionary["Title"] as? String
        year = dictionary["Year"] as? String
        imdbID = dictionary["imdbID"] as? String
        type = dictionary["Type"] as? String
        poster = dictionary["Poster"] as? String
    }
}
