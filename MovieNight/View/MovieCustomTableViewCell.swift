//
//  MovieCustomTableViewCell.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 6.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieCustomTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeView: UIView!
    
    //MARK: - Function
    func getMoviePoster(imageURL: String) {
        Alamofire.request(imageURL).responseImage { response in
            if let image = response.result.value {
                UIView.animate(withDuration: 0.3) {
                    self.movieImageView.image = image
                }
            }
        }
    }
    
    func prepareForDrawing(searchMovieDetails: SearchMovieDetails) {
        if searchMovieDetails.poster! == "N/A" {
            movieImageView.image = UIImage(named: "logo")
        } else {
            getMoviePoster(imageURL: searchMovieDetails.poster!)
        }
        titleLabel.text = searchMovieDetails.title
        yearLabel.text = searchMovieDetails.year
        typeLabel.text = searchMovieDetails.type
        if searchMovieDetails.type == "movie" {
            typeView.backgroundColor =  UIColor.init(named: "movieTypeTableCellBackground")
        } else if searchMovieDetails.type == "series" {
            typeView.backgroundColor =  UIColor.init(named: "seriesTypeTableCellBackground")
        } else if searchMovieDetails.type ==  "episode" {
            typeView.backgroundColor =  UIColor.init(named: "episodeTypeTableCellBackground")
        } else if searchMovieDetails.type ==  "game" {
            typeView.backgroundColor =  UIColor.init(named: "gameTypeTableCellBackground")
        }
    }
}

