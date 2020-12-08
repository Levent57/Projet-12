//
//  ViewController.swift
//  MyShows
//
//  Created by Levent Bostanci on 20/10/2020.
//

import UIKit

class MovieController: UIViewController {
    

    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var moviesByCategory: [MoviesByCategory] = []
    var alertController: UIAlertController?

    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downoladMovies()
    }

    //MARK: - Functions
    
    //Segue to DetailController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail", let detail = segue.destination as? DetailController {
            detail.movie = sender as? Movie
        }
    }
    
    func downoladMovies() {
        MovieCategory.allCases.forEach { (cat) in
            let new = MoviesByCategory(cat: cat)
            self.moviesByCategory.append(new)
        }
        moviesByCategory.forEach { (mbc) in
            MovieService().getMovie(category: mbc.cat, selection: .movie) { (success, results) in
                if success {
                mbc.movies = results!
                print(mbc.movies.count)
                self.tableView.reloadData()
                } else {
                    self.showErrorPopup(title: "Pas de connexion", message: "Veuillez vous reconnecter à internet")
                }
            }
        }
    }
}

//MARK: - TableView extension

extension MovieController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesByCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movies = moviesByCategory[indexPath.section].movies
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell {
            cell.setup(movies, self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moviesByCategory[section].name
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 20)!
        header.textLabel?.textColor = UIColor.black
    }
}


