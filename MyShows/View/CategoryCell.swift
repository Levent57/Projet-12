//
//  CategoryCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 24/10/2020.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var controller: ViewController!
    
    func setup(_ movies: [Movie], _ controller: ViewController) {
        self.controller = controller
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.movies = movies
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout = setNeedsLayout()
    }
    
    func setNeedsLayout() -> UICollectionViewFlowLayout {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 185, height: 250)
        l.minimumLineSpacing = 30
        l.scrollDirection = .horizontal
        return l
    }
    
}

extension CategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setup(movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let movie = movies[indexPath.item]
//        controller.performSegue(withIdentifier: "Detail", sender: movie)
        if let mainViewController = parentViewController as? ViewController {
//            guard movies.count > indexPath.row else { return }
            let movie = movies[indexPath.row]
            guard let detailVC = mainViewController.storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? DetailController else { return }
            detailVC.movie = movie
            detailVC.movieID = movie.id
            mainViewController.show(detailVC, sender: self)
        }
    }
}
//}

extension UIView {
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
