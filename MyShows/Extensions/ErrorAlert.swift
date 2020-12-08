//
//  ErrorAlert.swift
//  MyShows
//
//  Created by Levent Bostanci on 21/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Show error popup
    func showErrorPopup(title: String, message: String){
        DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}



