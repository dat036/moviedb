//
//  RecommendViewController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 17/05/2021.
//

import UIKit
import Alamofire
import ObjectMapper

class RecommendViewController : UIViewController {
    
    @IBOutlet var recommendCollection: UICollectionView!
    
    
    private var movieId = 0
    private var moviesRecommend = Array<Movie>()
    
    func initData(movieId: Int) {
        self.movieId = movieId
    }
    
    func reloadData(movies: MovieResponse){
        moviesRecommend = movies.results!
        recommendCollection.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendCollection.delegate = self
        recommendCollection.dataSource = self
        
        fetchMovieRecommend(movieId: movieId)
    }
}

extension RecommendViewController {
    static let URL_MOVIE_POPULAR = "https://api.themoviedb.org/3/movie/"
    static let PARAMETER_MOVIE_REQUEST: Parameters = [
        "api_key": "aa26b8d5bb328940b3887aefecf302e0"
    ]
    
    func fetchMovieRecommend(movieId: Int){
        let request = AF.request(
            MovieDetailViewController.URL_MOVIE_POPULAR+String(movieId)+"/recommendations",
            parameters: MovieDetailViewController.PARAMETER_MOVIE_REQUEST,
            encoding: URLEncoding(destination: .queryString))
        
        request.responseString { [self] temp in
            let result = temp.result
            do {
                let jsonString = try result.get()
                let movieResponse = Mapper<MovieResponse>().map(JSONString: jsonString)
                self.reloadData(movies: movieResponse!)
            } catch {
                
            }
        }
    }
}

extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = recommendCollection.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { fatalError("Unable to create table view cell")}
        cell.configureData(movie: moviesRecommend[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesRecommend.count
    }
}
