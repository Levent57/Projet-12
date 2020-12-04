//
//  SearchResultCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 08/11/2020.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var MovieTitleLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    let service = MovieService()
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        DispatchQueue.main.async {
            self.MovieTitleLabel.text = movie.title
            self.releaseDataLabel.text = "Date de sortie: \(movie.releaseDate)"
            self.posterImageView.load(185, movie.posterPath ?? "")
        }
    }
    
}
