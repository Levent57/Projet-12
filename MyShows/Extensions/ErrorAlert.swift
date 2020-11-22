//
//  ErrorAlert.swift
//  MyShows
//
//  Created by Levent Bostanci on 21/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorPopup(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

