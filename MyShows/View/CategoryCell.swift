//
//  CategoryCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 24/10/2020.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    
    var movies: [Movie] = []
    var controller: MovieController!
    
    //MARK: - Functions
    
    func setup(_ movies: [Movie], _ controller: MovieController) {
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

//MARK: - CollectionView extension

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
        if let mainViewController = parentViewController as? MovieController {
            let movie = movies[indexPath.row]
            guard let detailVC = mainViewController.storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? DetailController else { return }
            detailVC.movie = movie
            detailVC.movieID = movie.id
            mainViewController.show(detailVC, sender: self)
        }
    }
}


