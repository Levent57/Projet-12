//
//  TvShowsCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 10/11/2020.
//

import UIKit

class TvShowsCell: UITableViewCell{

    @IBOutlet weak var tvCollectionViewCell: UICollectionView!
    
    var movies: [TV] = []
    var controller: TvViewController!
    
    func setup(_ movies: [TV], _ controller: TvViewController) {
        self.controller = controller
        self.tvCollectionViewCell.delegate = self
        self.tvCollectionViewCell.dataSource = self
        self.movies = movies
        self.tvCollectionViewCell.reloadData()
        self.tvCollectionViewCell.collectionViewLayout = setNeedsLayout()
    }
    
    func setNeedsLayout() -> UICollectionViewFlowLayout {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 185, height: 250)
        l.minimumLineSpacing = 30
        l.scrollDirection = .horizontal
        return l
    }
    
}

extension TvShowsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCell", for: indexPath) as! TVShowsCollectionCell
        cell.setup(movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        controller.performSegue(withIdentifier: "TvDetail", sender: movie)
    }
    
}
