//
//  SearchResultCell.swift
//  MyShows
//
//  Created by Levent Bostanci on 08/11/2020.
//

import UIKit

class SearchResultCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var MovieTitleLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    //MARK: - Variables
    
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
    
    //MARK: - Functions
    
    func updateViews() {
        guard let movie = movie else { return }
        DispatchQueue.main.async {
            self.MovieTitleLabel.text = movie.title
            self.releaseDataLabel.text = "Date de sortie: \(movie.releaseDate)"
            self.posterImageView.load(185, movie.posterPath ?? "")
        }
    }
    
}
