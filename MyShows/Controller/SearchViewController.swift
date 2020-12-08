//
//  SearchViewController.swift
//  MyShows
//
//  Created by Levent Bostanci on 29/10/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchTableView: UITableView! { didSet{searchTableView.tableFooterView = UIView() } }
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var service = MovieService()
    private var movieTitle = [String]()
    var movies = [Movie]()

    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
    }

    //MARK: - Functions
    
    //Hidden Keyborard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //Segue to DetailController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let resultVC = segue.destination as? DetailController else { return }
            resultVC.movies = movies
        }
    }
}

//MARK: - SearchBar extension

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        let encodeSearch = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if searchBar.text!.isEmpty {
            showErrorPopup(title: "Aucun text", message: "Veuillez taper le nom d'un film à rechercher")
        }
        service.searchMovie(selection: .search, query: [encodeSearch]) { (success, movie) in
            guard let fetchedMovies = movie else { return }
            self.movies = fetchedMovies
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
                self.searchBar.endEditing(true)
                searchBar.text = nil
            }
        }
    }
}

//MARK: - TableView extension

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
    
    //Show message when tableView is empty
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Recherchez vos films ici"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return movies.isEmpty ? 150 : 0
    }
}
