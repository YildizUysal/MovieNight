//
//  MovieCustomTableViewCell.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 6.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import UIKit
import Alamofire

class MovieCustomTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    //MARK: - Properties
    
    //MARK: - Function
    func prepareForDrawing(searchMovieDetails: SearchMovieDetails) {
        //        if searchMovieDetails.poster?.isEmpty == true {
        movieImageView.image = UIImage(named: "logo")
        //        } else {
        
        //            movieImageView.imageFromUrl(urlString: searchMovieDetails.poster!)
        //        }
        titleLabel.text = searchMovieDetails.title
        yearLabel.text = searchMovieDetails.year
        typeLabel.text = searchMovieDetails.type
        
        if searchMovieDetails.type == "movie" {
            self.backgroundColor =  UIColor.init(named: "movieTypeTableCellBackground")
        } else if searchMovieDetails.type == "series" {
            self.backgroundColor =  UIColor.init(named: "seriesTypeTableCellBackground")
        } else if searchMovieDetails.type ==  "episode" {
            self.backgroundColor =  UIColor.init(named: "episodeTypeTableCellBackground")
        }
        
    }
    
    //MARK: - Actions
    
    
}

//extension UIImageView {
//    public func imageFromUrl(urlString: String) {
//        if let url = NSURL(string: urlString) {
//            let request = NSURLRequest(url: url as URL)
//            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.mainQueue) {
//                (response: URLResponse!, data: NSData!, error: NSError!) -> Void in
//                self.image = UIImage(data: data as Data)
//            }
//        }
//    }
//}
