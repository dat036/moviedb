//
//  CastViewController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 14/05/2021.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class CastViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    var movieId = 0
    var castList = Array<Cast>()
    
    func initData(movieId: Int) {
        self.movieId = movieId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetail(movieId: movieId)
    }
}

extension CastViewController {
    static let URL_MOVIE_POPULAR = "https://api.themoviedb.org/3/movie/"
    static let PARAMETER_MOVIE_REQUEST: Parameters = [
        "api_key": "aa26b8d5bb328940b3887aefecf302e0"
    ]
    
    func fetchMovieDetail(movieId: Int){
        let request = AF.request(
            MovieDetailViewController.URL_MOVIE_POPULAR+String(movieId)+"/credits",
            parameters: MovieDetailViewController.PARAMETER_MOVIE_REQUEST,
            encoding: URLEncoding(destination: .queryString))
        
        request.responseString { [self] temp in
            let result = temp.result
            do {
                let jsonString = try result.get()
                let castResponse = Mapper<CastResponse>().map(JSONString: jsonString)
                self.castList = (castResponse?.cast)!
                self.tableview.reloadData()
            } catch {
                
            }
        }
    }
}

extension CastViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell else { fatalError("Unable to create table view cell")}
        cell.injectData(cast: castList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
