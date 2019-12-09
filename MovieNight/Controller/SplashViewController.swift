//
//  ViewController.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 5.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Properties
    var titleSearch : String?
    var alertPresent : AlertPresenter?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresent = AlertPresenter(controller: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Connectivity.isConnectedToInternet {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.performSegue(withIdentifier: "toMainScreen", sender: nil)
            }
        } else {
            let title = "No Connection"
            let message = "Check your connection. \n Then try again"
            alertPresent?.presentAlert(title: title, message: message)
            self.titleLabel.alpha = 1
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationLabel()
    }
    
    //MARK: - Function
    func animationLabel() {
        UIView.animate(withDuration: 0.8,
                       delay:0.4,
                       options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
                       animations: { self.titleLabel.alpha = 0 },
                       completion: nil)
    }
}

