//
//  DetailController.swift
//  MyShows
//
//  Created by Levent Bostanci on 29/10/2020.
//

import UIKit
import SafariServices

class DetailController: UIViewController {
    
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var detailBackgroundView: UIView!
    @IBOutlet weak var circularRateView: CircularRateView!
    
    var movie: Movie!
    var movies: [Movie]?
    var service = MovieService()
//    var movieID: Int?
//    var cast: [Cast]?
//    var videoList: [Videos]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(animateProgress), with: nil, afterDelay: 0.5)
        setupLabel()
        detailBackgroundView.layer.cornerRadius = 15
    }
    
    func setupLabel() {
        guard let m = movie else { return }
        navigationItem.title = m.title
        originalTitleLabel.text = m.originalTitle
        releaseDateLabel.text = "Date de sortie: \(m.releaseDate)"
        ratingLabel.text = "Note: \(m.voteAverage)"
        overviewLabel.text = m.overview
        posterImageView.load(185, m.posterPath ?? "")
        
    }

    @objc func animateProgress() {
        let cP = self.view.viewWithTag(101) as! CircularRateView
        cP.setProgressWithAnimation(duration: 0.7, value: 0.2)
        cP.trackColor = UIColor.white
        
        let average = movie.voteAverage
        let one = 1.0...1.9
        let two = 2.0...2.9
        let three = 3.0...3.9
        let four = 4.0...4.9
        let five = 5.0...5.9
        let six = 6.0...6.9
        let seven = 7.0...7.9
        let eight = 8.0...8.9
        let nine = 9.0...9.9
        let ten = 10.0

        if one ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.1)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if two ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.2)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if three ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.3)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if four ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.4)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if five ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.5)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if six ~= average {
           cP.setProgressWithAnimation(duration: 0.7, value: 0.6)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if seven ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.7)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if eight ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.8)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if nine ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.9)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if ten ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 1.0)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.0)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
    
    
}
