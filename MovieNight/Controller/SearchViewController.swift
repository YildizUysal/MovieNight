//
//  SearchViewController.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 6.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var lodingAnimationView: UIView!
    
    //MARK: - Properties
    let apiKey : String = "586fbaa9"
    var service : Service!
    
    //Arrays
    var nsArray = [NSArray]()
    var detailsArray = [SearchMovieDetails]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        animationStart()
        let url = "http://www.omdbapi.com/?apikey=\(apiKey)&s=love"
        
        Alamofire.request(url).responseJSON { (response) in
            if let jsonDictionary = response.result.value as? [String: Any] {
                let searchDic = jsonDictionary["Search"] as! NSArray
                for i in 0..<searchDic.count{
                    let dictionary = SearchMovieDetails.init(dictionary: searchDic[i] as! [String : Any])
                    self.detailsArray.append(dictionary)
                }
                DispatchQueue.main.async {
                            self.tableView.reloadData()
                }
            }
            
        }
    }
    
    //MARK: - Function
//    func animationStart() {
//        UIView.animate(withDuration: 0.4,
//                       delay:0.0,
//                       options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
//                       animations: { self.lodingAnimationView.alpha = 0 },
//                       completion: nil)
//    }
//
//    func animationStop() {
//        lodingAnimationView.alpha = 0
//    }
    
    //MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        guard let movieTitle = searchTextField.text, !movieTitle.isEmpty else {
            return
        }
        
        service = Service(APIKey: apiKey)
        service.getSerachMovie(s: movieTitle) { (searchMovie) in
            if let searchMovie = searchMovie{
                let dictionary = ["Poster":searchMovie.poster as Any,
                                  "imdbID":searchMovie.imdbID as Any,
                                  "Title": searchMovie.title as Any,
                                  "Year" : searchMovie.year as Any,
                                  "Type" : searchMovie.type as Any
                    ] as [String : Any]
                let details = SearchMovieDetails(dictionary: dictionary)
                self.detailsArray.append(details)
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCustomTableViewCell {
            let movie = detailsArray[indexPath.row]
            cell.prepareForDrawing(searchMovieDetails: movie)
            return cell
        }
        return UITableViewCell()
    }
}
