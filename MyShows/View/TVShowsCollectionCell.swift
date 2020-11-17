//
//  TVShowsCollectionCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 16/11/2020.
//

import UIKit

class TVShowsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var posterTvImageView: UIImageView!
    @IBOutlet weak var tvLabel: UILabel!
    
    var movie: TV!
    
    func setup(_ movie: TV) {
        self.movie = movie
        contentView.layer.cornerRadius = 10
        tvLabel.text = self.movie.name
        posterTvImageView.load(185, self.movie.poster_path ?? "")
    }
}
