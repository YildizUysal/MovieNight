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
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    
    //MARK: - Properties
    var alertPresent : AlertPresenter?
    var requestCount : Int = 1
    let apiKey : String = "586fbaa9"
    
    //Arrays
    var detailsArray = [SearchMovieDetails]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresent = AlertPresenter(controller: self)
        infoLabel.text = "Merhaba uygulamamızı kullanmaya başlamak için film aramayı deneyin.\n Bir sorun olursa sizi uyaracağız. \n Uygulamamızı yükleyip kullandığın için teşekkürler keyifli seyirler. "
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if detailsArray.count <= 0 {
            tableView.alpha = 0
            infoView.alpha = 1
        }
    }
    
    // MARK: - Function
    func searchApiAlamofire() {
        guard let movieTitle = searchTextField.text, !movieTitle.isEmpty else {
            return
        }
        
        infoView.alpha = 1
        infoLabel.text = "Sizi biraz bekleteceğiz. Aramayı gerçekleştiriyoruz. Bu işlem internetinizin hızına ve aradığınız kelimenin çok kullanılmasına bağlı olarak uzun sürebilir. Bunu aklınızda bulundurup daha detaylı bir arama yapabilirsiniz. Sabırınız için teşekkür ederiz."
        
        let url = "http://www.omdbapi.com/?apikey=\(apiKey)&s=\(movieTitle)"
        
        Alamofire.request(url).responseJSON { (response) in
            self.activityIndicator.startAnimating()
            if let jsonDictionary = response.result.value as? [String: Any] {
                self.detailsArray.removeAll()
                let searchMovieDic = SearchMovie.init(dictionary: jsonDictionary)
                if searchMovieDic.response! == "True" {
                    self.requestCount = Int(searchMovieDic.totalResults!)!
                    if  self.requestCount % 10 != 0 {
                        self.requestCount = (self.requestCount / 10) + 1
                    } else {
                        self.requestCount = self.requestCount / 10
                    }
                } else {
                    self.infoLabel.text = "Küçük bir hata oldu. Lütfen tekrar deneyiniz."
                    print("Bad Request")
                    return
                }
            }
            for j in 1...self.requestCount {
                let newURL = "\(url)&page=\(j)"
                Alamofire.request(newURL).responseJSON { (response) in
                    if let responseDic = response.result.value as? [String: Any] {
                        let searchDic = responseDic["Search"] as! NSArray
                        let searchMovieDictionary = SearchMovie.init(dictionary: responseDic)
                        if searchMovieDictionary.response == "True" {
                            for i in 0..<searchDic.count{
                                let dictionary = SearchMovieDetails.init(dictionary: searchDic[i] as! [String : Any])
                                self.detailsArray.append(dictionary)
                            }
                            if j == self.requestCount {
                                self.tableView.alpha = 1
                                self.infoView.alpha = 0
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    self.activityIndicator.stopAnimating()
                                }
                            }
                        } else if searchMovieDictionary.response == "False" {
                            if self.detailsArray.count != 0 {
                                self.tableView.alpha = 1
                                self.infoView.alpha = 0
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    self.activityIndicator.stopAnimating()
                                }
                            }
                            let title = "Error"
                            let message = "\(searchMovieDictionary.error ?? "")"
                            self.alertPresent?.presentAlert(title: title, message: message)
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsView" {
            let destinationVC = segue.destination as! DetailsMovieViewController
            destinationVC.titleForURL = sender as? String
        }
    }
    
    //MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchApiAlamofire()
    }
}

//MARK: - TableView
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = detailsArray[indexPath.row]
        let titleSelected = selectedMovie.title
        performSegue(withIdentifier: "toDetailsView", sender: titleSelected)
    }
}
