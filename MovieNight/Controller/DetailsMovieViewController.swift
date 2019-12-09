//
//  DetailsMovieViewController.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 8.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailsMovieViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Properties
    var showTitle = ["Title","Actors","Year","Plot","Website","imdbRating","Runtime",
                     "Genre","Director","Writer","Language","Country","Awards"]
    let apiKey : String = "586fbaa9"
    var detailsMovie : MovieDetails?
    var detailsTitle = [String]()
    var detailsContent = [Any]()
    var titleForURL : String?
    var detailMovie = [MovieDetails]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails()
    }
    
    //MARK: - Function
    func getMoviePosterImage(imageURL: String) {
        Alamofire.request(imageURL).responseImage { response in
            if let image = response.result.value {
                UIView.animate(withDuration: 0.3) {
                    self.movieImage.image = image
                }
            }
        }
    }
    
    func getMovieDetails() {
        detailsTitle.removeAll()
        detailsContent.removeAll()
        if titleForURL?.isEmpty != true && titleForURL != ""{
            let titleURL = titleForURL!.replacingOccurrences(of: " ", with: "+")
            let url = "http://www.omdbapi.com/?apikey=\(apiKey)&t=\(titleURL)&plot=full"
            Alamofire.request(url).responseJSON { (response) in
                if let receivedValue = response.result.value as? [String: Any] {
                    self.detailsMovie =  MovieDetails.init(dictionary: receivedValue)
                    self.detailMovie.append(self.detailsMovie!)
                   
                    if (self.detailsMovie?.poster) != nil {
                        self.getMoviePosterImage(imageURL: self.detailsMovie!.poster!)
                    } else {
                        self.movieImage.image = UIImage(named: "logo")
                    }
                    
                    for value in receivedValue {
                        let movieTitle = value.key
                        let movieContent = value.value
                        self.detailsTitle.append(movieTitle)
                        self.detailsContent.append(movieContent)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}

// MARK: - TableView
extension DetailsMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showTitle.contains(detailsTitle[indexPath.row]) {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showTitle.contains(detailsTitle[indexPath.row]) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsMovieCell", for: indexPath) as? MovieDetailsTableViewCell {
                cell.prepareForDrawing(detailsTitle: detailsTitle[indexPath.row], detailsContent: detailsContent[indexPath.row])
                return cell
            }
        }
        let visibleCell = UITableViewCell()
        visibleCell.isSelected = false
        visibleCell.isHidden = true
        return visibleCell
    }
}
