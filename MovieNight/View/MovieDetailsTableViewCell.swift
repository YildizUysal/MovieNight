//
//  MovieDetailsTableViewCell.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 8.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    @IBOutlet weak var detailsLabel: UILabel!
    
    //MARK: - Function
    func prepareForDrawing(detailsTitle: String , detailsContent: Any) {
        if let content = detailsContent as? String {
            if content == "N/A" {
                detailsLabel.text = "\(detailsTitle) : No info"
            } else {
                if detailsTitle == "imdbRating" {
                    detailsLabel.text = "IMDB Rating : \(content)"
                } else {
                    detailsLabel.text = "\(detailsTitle) : \(content)"
                }
            }
        }
    }
}
