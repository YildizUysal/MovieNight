//
//  Service.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 6.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    // http://www.omdbapi.com/?apikey=586fbaa9&t=love
    let apiKey : String
    let baseURL : URL?
    
    init(APIKey: String) {
        self.apiKey = APIKey
        baseURL = URL(string: "http://www.omdbapi.com/?apikey=\(apiKey)")
    }
    
    func getSerachMovie(s: String, completion: @escaping (SearchMovieDetails?) -> Void) {
        
        let url = "\(baseURL!)&s=\(s)"
        
        Alamofire.request(url).responseJSON { (response) in
            if let jsonDictionary = response.result.value as? [String: Any] {
                if let search = jsonDictionary["Search"] as? [String : Any] {
                    let searchDetails = SearchMovieDetails.init(dictionary: search)
                    completion(searchDetails)
                }
            }
                
        }
        
        
    }
    
}
