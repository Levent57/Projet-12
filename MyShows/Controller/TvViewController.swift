//
//  TvViewController.swift
//  MyShows
//
//  Created by Levent Bostanci on 10/11/2020.
//

import UIKit

class TvViewController: UIViewController {
    
    var movieService = MovieService()
    var shows: [Movie] = []
//    var movieByCategory: [MoviesByCategory] = []

    @IBOutlet weak var tvCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        tvCollectionView.delegate = self
        tvCollectionView.dataSource = self
        loadLatestTvData()
        super.viewDidLoad()
    }
    
    func loadLatestTvData() {
        movieService.getTvShows(selection: .trendingTV) { (success, tvShows) in
            guard let fetchedTv = tvShows else { return }
            self.shows = fetchedTv
            DispatchQueue.main.async {
                self.tvCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TvDetail", let detail = segue.destination as? DetailController {
            detail.movie = sender as? Movie
        }
     }
    
}

extension TvViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTv", for: indexPath) as! TvShowsCell
        cell.setup(shows[indexPath.item])
        return cell
//        let show = shows[indexPath.section]
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTv", for: indexPath) as? TvShowsCell {
//            cell.setup(shows, self)
//        return cell
//        }
//        return UICollectionViewCell()
//        let onAirCell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTv", for: indexPath) as! TvShowsCell
//        let tv = shows[indexPath.row]
//        onAirCell.movie = tv
//        onAirCell.tvShowsPosterImageView.load(185, tv.posterPath ?? "")
//        return onAirCell
    }
}
