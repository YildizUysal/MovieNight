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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var sayac : Int = 1
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
        //        let url = "http://www.omdbapi.com/?apikey=\(apiKey)&s=love"
        //
        //        Alamofire.request(url).responseJSON { (response) in
        //            if let jsonDictionary = response.result.value as? [String: Any] {
        //                let searchDic = jsonDictionary["Search"] as! NSArray
        //                for i in 0..<searchDic.count{
        //                    let dictionary = SearchMovieDetails.init(dictionary: searchDic[i] as! [String : Any])
        //                    self.detailsArray.append(dictionary)
        //                }
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //            }
        //
        //        }
    }
    
    // MARK: - Function
    //    func elementShowFunc() {
    //          if historyArray.count > 0 {
    //              UIView.animate(withDuration: 0.5) {
    //                  self.tableView.alpha = 1
    //                  self.infoView.alpha = 0
    //              }
    //          } else {
    //              UIView.animate(withDuration: 0.5) {
    //                  self.tableView.alpha = 0
    //                  self.infoView.alpha = 1
    //              }
    //          }
    //      }
    
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
    //    func searchApiAlamofire() {
    //        guard let movieTitle = searchTextField.text, !movieTitle.isEmpty else {
    //                   return
    //               }
    //        let url = "http://www.omdbapi.com/?apikey=\(apiKey)&s=\(movieTitle)"
    //
    //             Alamofire.request(url).responseJSON { (response) in
    //                 if let jsonDictionary = response.result.value as? [String: Any] {
    //                    self.detailsArray.removeAll()
    //                    let totalResult = jsonDictionary["totalResults"]
    //                    print(totalResult as! Int)
    //                     let searchDic = jsonDictionary["Search"] as! NSArray
    //
    //                     for i in 0..<searchDic.count{
    //                         let dictionary = SearchMovieDetails.init(dictionary: searchDic[i] as! [String : Any])
    //                         self.detailsArray.append(dictionary)
    //                     }
    //                     DispatchQueue.main.async {
    //                        UIView.animate(withDuration: 0.5) {
    //                            self.tableView.reloadData()
    //                        }
    //                     }
    //                 }
    //
    //             }
    //    }
    

    //
    //    if let searchDictionary = response.result.value as? [String: Any] {
    //                           let searchDict = SearchMovie.init(dictionary: searchDictionary)
    //                           if searchDict.response! == "True" {
    //                               let searchDic = searchDict.search! as NSArray
    //                               for i in 0..<searchDic.count{
    //                                   let dictionary = SearchMovieDetails.init(dictionary: searchDic[i] as! [String : Any])
    //                                   self.detailsArray.append(dictionary)
    //                               }
    //                           }
    //                           if j == self.sayac {
    //                               UIView.animate(withDuration: 0.5) {
    //                                   self.tableView.alpha = 1
    //                               }
    //                               DispatchQueue.main.async {
    //                                   self.tableView.reloadData()
    //                                   self.activityIndicator.stopAnimating()
    //                               }
    //                           }
    //                       } else {
    //                           print("Bad Request")
    //                           return
    //                       }
    
    func searchApiAlamofire() {
        guard let movieTitle = searchTextField.text, !movieTitle.isEmpty else {
            return
        }
        let url = "http://www.omdbapi.com/?apikey=\(apiKey)&s=\(movieTitle)"
        
        Alamofire.request(url).responseJSON { (response) in
            self.activityIndicator.startAnimating()
            if let jsonDictionary = response.result.value as? [String: Any] {
                self.detailsArray.removeAll()
                let searchMovieDic = SearchMovie.init(dictionary: jsonDictionary)
                if searchMovieDic.response! == "True" {
                    self.sayac = Int(searchMovieDic.totalResults!)!
                    if  self.sayac % 10 != 0 {
                        self.sayac = (self.sayac / 10) + 1
                    } else {
                        self.sayac = self.sayac / 10
                    }
                } else {
                    print("Bad Request")
                    return
                }
            }
            for j in 1...self.sayac {
                let newURL = "\(url)&page=\(j)"
                Alamofire.request(newURL).responseJSON { (response) in
                    if let searchDictionary = response.result.value as? [String: Any] {
                        let searchDic = searchDictionary["Search"] as! NSArray
                        for i in 0..<searchDic.count{
                            let dictionary = SearchMovieDetails.init(dictionary: searchDic[i] as! [String : Any])
                            self.detailsArray.append(dictionary)
                        }
                    }
                    if j == self.sayac {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.activityIndicator.stopAnimating()
                        }
                    }
                    
                }
            }
        }
        
    }
    
    
    func searchApi() {
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
    
    //MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchApiAlamofire()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
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
