//
//  HomeMovieController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 10/05/2021.
//

import UIKit
import Alamofire
import ObjectMapper

class  HomeViewController: UITableViewController{
    
    @IBOutlet var tableview: UITableView!
    
    var movieCategories = Array<MovieResponse>()
    
    @IBAction func returned(segue: UIStoryboardSegue){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFilms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func reloadDataMovies(listMovie movies: MovieResponse){
        movieCategories.append(movies)
        tableview.reloadData()
    }
    
    func goToMovieDetail(id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetail = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            movieDetail.initData(movieId: id)
            navigationController?.pushViewController(movieDetail, animated: true)
        }
    }
}

extension HomeViewController: CollectionCellDelegate {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { fatalError("Unable to create table view cell")}
        var title = ""
        switch indexPath.row {
        case 0:
            title = "Trending"
        case 1:
            title = "Top Rated"
        case 2:
            title = "Upcoming"
        default:
            title = "Trending"
        }
        cell.configureData(trending: title, category: "Movie", listMovie: movieCategories[indexPath.row].results!)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func onSelectedItem(movieId: Int) {
        goToMovieDetail(id: movieId)
    }
}

extension HomeViewController {
    static let URL_MOVIE_POPULAR = "https://api.themoviedb.org/3/movie/popular"
    static let URL_MOVIE_TOP_RATED = "https://api.themoviedb.org/3/movie/top_rated"
    static let URL_MOVIE_UPCOMING = "https://api.themoviedb.org/3/movie/upcoming"
    
    static let PARAMETER_MOVIE_REQUEST: Parameters = [
        "api_key": "aa26b8d5bb328940b3887aefecf302e0"
    ]
    func fetchFilms(){
        fetchMovie(url: HomeViewController.URL_MOVIE_POPULAR, parameters: HomeViewController.PARAMETER_MOVIE_REQUEST)
        fetchMovie(url: HomeViewController.URL_MOVIE_POPULAR, parameters: HomeViewController.PARAMETER_MOVIE_REQUEST)
        fetchMovie(url: HomeViewController.URL_MOVIE_UPCOMING, parameters: HomeViewController.PARAMETER_MOVIE_REQUEST)
    }
    
    func fetchMovie(url: String, parameters: Parameters) {
        let request = AF.request(
            url,
            parameters: parameters,
            encoding: URLEncoding(destination: .queryString))
        
        request.responseString { temp in
            let result = temp.result
            do {
                let jsonString = try result.get()
                let movieResponse = Mapper<MovieResponse>().map(JSONString: jsonString)
                self.reloadDataMovies(listMovie: movieResponse!)
            } catch {
                
            }
        }
    }
}

