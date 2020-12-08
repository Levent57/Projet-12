//
//  ExtensionUIImagesView.swift
//  MyShows
//
//  Created by Levent Bostanci on 26/10/2020.
//

import Foundation
import UIKit

extension UIImageView {

    //Load image
    func load(_ size: Int, _ path: String) {
        let urlString = "http://image.tmdb.org/t/p/" + "w\(size)//" + path
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (d, _, _) in
            DispatchQueue.main.async {
                if let data = d {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}


extension UIView {
    
    // Assists with pushing data to detail view controller
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
