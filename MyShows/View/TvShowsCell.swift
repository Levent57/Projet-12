//
//  TvShowsCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 10/11/2020.
//

import UIKit

class TvShowsCell: UITableViewCell{

    @IBOutlet weak var tvCollectionViewCell: UICollectionView!
    
    var shows: [TV] = []
    var controller: TvViewController!
    
    func setup(_ shows: [TV], _ controller: TvViewController) {
        self.controller = controller
        self.tvCollectionViewCell.delegate = self
        self.tvCollectionViewCell.dataSource = self
        self.shows = shows
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
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCell", for: indexPath) as! TVShowsCollectionCell
        cell.setup(shows[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let mainViewController = parentViewController as? TvViewController {  
            let tv = shows[indexPath.row]
            guard let detailVC = mainViewController.storyboard?.instantiateViewController(withIdentifier: "tvDetail") as? TvDetailController else { return }
            detailVC.tv = tv
            detailVC.tvID = tv.id
            mainViewController.show(detailVC, sender: self)
        }
    }
    
}
