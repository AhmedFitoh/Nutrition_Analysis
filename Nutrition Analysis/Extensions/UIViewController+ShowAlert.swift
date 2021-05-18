//
//  UIViewController+ShowAlert.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/17/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, completion: (()->())?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { (_) in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}
