//
//  MovieCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 24/10/2020.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var movie: Movie!
    
    func setup(_ movie: Movie) {
        self.movie = movie
        contentView.layer.cornerRadius = 10
        titleLable.text = self.movie.title
        posterImageView.load(185, self.movie.posterPath ?? "")
//        posterImageView.load(185, self.movie.backdrop_path)
// still_path
    }
    
}
