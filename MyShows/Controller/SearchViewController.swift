//
//  SearchViewController.swift
//  MyShows
//
//  Created by Levent Bostanci on 29/10/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var service = MovieService()
    private var movieTitle = [String]()
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let resultVC = segue.destination as? DetailController else { return }
            resultVC.movies = movies
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        service.searchMovie(selection: .search, query: [searchTerm]) { (success, movie) in
            guard let fetchedMovies = movie else { return }
            self.movies = fetchedMovies
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
                searchBar.text = nil
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as!SearchResultCell
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard movies.count > indexPath.row else { return }
        let movie = movies[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? DetailController else { return }
        detailVC.movie = movie
        detailVC.movieID = movie.id
        self.showDetailViewController(detailVC, sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }


}
