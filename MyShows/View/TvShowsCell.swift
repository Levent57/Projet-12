//
//  TvShowsCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 10/11/2020.
//

import UIKit

class TvShowsCell: UICollectionViewCell {
    
    @IBOutlet weak var tvShowsPosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var gradient: CAGradientLayer!
//    var movies: [Movie] = []
    var controller: TvViewController!
    
    
    override func awakeFromNib() {
        imageGradient()
    }
    
    var movie: Movie!

    func setup(_ movie: Movie) {
        self.movie = movie
        contentView.layer.cornerRadius = 10
        tvShowsPosterImageView.load(185, self.movie.posterPath ?? "")
        titleLabel.text = self.movie.title
    }
//    func setup(_ movies: [Movie], _ controller: TvViewController) {
//        self.controller = controller
//        contentView.layer.cornerRadius = 10
//        self.movies = movies
//    }

    func imageGradient() {
        gradient = CAGradientLayer()
        gradient.frame = tvShowsPosterImageView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.6, 0.8, 1]
        tvShowsPosterImageView.layer.mask = gradient
    }
}
