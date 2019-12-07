//
//  Movie.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 5.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    
    var title: String?
    var year: String?
    var rated: String?
    var released: String?
    var runtime: String?
    var genre: String?
    var director: String?
    var writer: String?
    var actors: String?
    var plot: String?
    var language: String?
    var country: String?
    var awards: String?
    var poster: String?
    var ratings: String?
    var imdbRating: String?
    var imdbID: String?
    var type: String?
    var response: String?

    init(dictionary: [String: Any]) {
        title = dictionary["Title"] as? String
        year = dictionary["Year"] as? String
        rated = dictionary["Rated"] as? String
        released = dictionary["Released"] as? String
        runtime = dictionary["Runtime"] as? String
        genre = dictionary["Genre"] as? String
        director = dictionary["Director"] as? String
        writer = dictionary["Writer"] as? String
        actors = dictionary["Actors"] as? String
        plot = dictionary["Plot"] as? String
        language = dictionary["Language"] as? String
        country = dictionary["Country"] as? String
        awards = dictionary["Awards"] as? String
        poster = dictionary["Poster"] as? String
        ratings = dictionary["Ratings"] as? String
        imdbRating = dictionary["imdbRating"] as? String
        imdbID = dictionary["imdbID"] as? String
        type = dictionary["Type"] as? String
        response = dictionary["Response"] as? String
    }
    
}
