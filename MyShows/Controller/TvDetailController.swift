//
//  TvDetailController.swift
//  MyShows
//
//  Created by Levent Bostanci on 16/11/2020.
//

import Foundation
import UIKit
import SafariServices

class TvDetailController: UIViewController {
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var circularProgressView: CircularRateView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var trailerCollection: UICollectionView!
    
    
    var tv: TV!
    var tvShow: [TV]?
    
    var service = MovieService()
    var tvID: Int?
    var videoList:[Videos]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(animateProgress), with: nil, afterDelay: 0.5)
        setupLabel()
        trailerCollection.dataSource = self
        trailerCollection.delegate = self
        service.tvVideos(tvID: (tvID)!) { (videos: VideoInfo) in
            if let allVideos = videos.results{
                self.videoList = allVideos
                DispatchQueue.main.async {
                    if self.videoList?.count == 0 {

                    }
                    self.trailerCollection.reloadData()
                }
            }
        }
    }
    
    func setupLabel() {
        guard let t = tv else { return }
        navigationItem.title = t.name
        titleLabel.text = t.original_name
        overviewTextView.text = t.overview
        ratingLabel.text = String(t.vote_average)
        releaseDateLabel.text = t.first_air_date
        posterImageView.load(185, t.poster_path ?? "")
        backGroundImageView.load(1280, t.backdrop_path ?? "")
    }
    
    
    @objc func animateProgress() {
        let cP = self.view.viewWithTag(101) as! CircularRateView
        cP.setProgressWithAnimation(duration: 0.7, value: 0.2)
        cP.trackColor = UIColor.white
        let average = tv.vote_average
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
    
    // Opens trailer in Youtube when tapped
    @objc func tapVideo(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: self.trailerCollection)
        let indexPath = self.trailerCollection.indexPathForItem(at: location)
        if let index = indexPath {
            let video_one = self.videoList![index[1]]
            if let video_key = video_one.key{
                let videoURL = service.youtubeURL(path: video_key)
                if let videourl = videoURL{
                    print(videourl)
                    
                    let safariVC = SFSafariViewController(url: videourl)
                    present(safariVC, animated: true, completion: nil)
                }
            }
        }
    }
}

extension TvDetailController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.trailerCollection{
            if let number = self.videoList?.count {
                return number
            }
            else{
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let trailerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvTrailerCell", for: indexPath) as! TrailerCell
        if collectionView == self.trailerCollection {
            let video_one = self.videoList![indexPath.row]
            if let video_key = video_one.key {
                let videoThumbURL = service.youtubeThumb(path: video_key)
                
                let url = videoThumbURL
                
                if let data = try? Data(contentsOf: url!)  {
                    trailerCell.backgroundImageView.image = UIImage(data: data)
                }  else {
                    print("There is no video data available")
                }
            } else {
                print("Unable to get youtube video")
            }
            trailerCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapVideo(_:))))
        }
        
        return trailerCell
    }
}

