//
//  AlertPresenter.swift
//  MovieNight
//
//  Created by Yıldız Uysal on 6.12.2019.
//  Copyright © 2019 YildizUysal. All rights reserved.
//

import UIKit

class AlertPresenter {
    
    private var controller : UIViewController
    
    init(controller : UIViewController) {
        self.controller = controller
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor =  UIColor.systemBlue
        let action  = UIAlertAction.init(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertWithActionArray(title: String, message: String, actionsName: [String]){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor =  UIColor.systemBlue
        //        alert.view.backgroundColor =  .white // Köşeler kare olur
        for i in 0..<actionsName.count {
            let alertAction = UIAlertAction.init(title: actionsName[i], style: .default, handler: nil)
            alert.addAction(alertAction)
        }
        controller.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertwithIdentifier(title: String, message: String, identifier: String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor =  UIColor.systemBlue
        
        let action  = UIAlertAction.init(title: "Okay",  style: .default) { (action) in
            self.controller.performSegue(withIdentifier: identifier, sender: nil)
        }
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
}
