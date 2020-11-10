//
//  ViewController.swift
//  MyShows
//
//  Created by Levent Bostanci on 20/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var moviesByCategory: [MoviesByCategory] = []
    
    @IBOutlet weak var tableView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        MovieCategory.allCases.forEach { (cat) in
            let new = MoviesByCategory(cat: cat)
            self.moviesByCategory.append(new)
        }
        moviesByCategory.forEach { (mbc) in
            MovieService().getMovie(category: mbc.cat, selection: .movie) { (success, results) in
                mbc.movies = results!
                print(mbc.movies.count)
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail", let detail = segue.destination as? DetailController {
            detail.movie = sender as? Movie
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
}

extension UIViewController {
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}

