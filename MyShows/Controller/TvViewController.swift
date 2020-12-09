//
//  TvViewController.swift
//  MyShows
//
//  Created by Levent Bostanci on 10/11/2020.
//

import UIKit

class TvViewController: UIViewController {
    

    //MARK: - Outlets
    
    @IBOutlet weak var tvShowsTableView: UITableView!
    
    // MARK: - Properties
    
    var tvByCategory: [TvShowsByCategory] = []
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvShowsTableView.delegate = self
        tvShowsTableView.dataSource = self
        downloadTvShows()
    }
    
    //MARK: - Functions
    
    //Segue to DetailController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TvDetail", let detail = segue.destination as? TvDetailController {
            detail.tv = sender as? TV
        }
    }
    
    func downloadTvShows() {
        TvShowCategory.allCases.forEach { (tscat) in
            let new = TvShowsByCategory(tvCat: tscat)
            self.tvByCategory.append(new)
        }
        tvByCategory.forEach { (tsbc) in
            MovieService().getTvShows(category: tsbc.tvCat, selection: .trendingTV) { (success, results) in
                if success {
                    tsbc.tvShows = results!
                    print(tsbc.tvShows.count)
                    self.tvShowsTableView.reloadData()
                } else {
                    self.showErrorPopup(title: "Pas de connexion", message: "Veuillez vous reconecter à internet")
                }
            }
        }
    }
}

//MARK: - TableView extension

extension TvViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tvByCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvShows = tvByCategory[indexPath.section].tvShows
        if let cell = tvShowsTableView.dequeueReusableCell(withIdentifier: "TVShowCell") as? TvShowsCell {
            cell.setup(tvShows, self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tvByCategory[section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 20)!
        header.textLabel?.textColor = UIColor.black
    }
    
}
