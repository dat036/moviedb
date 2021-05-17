//
//  MovieDetailViewController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 12/05/2021.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import Parchment

class MovieDetailViewController : UIViewController{
    
    @IBOutlet var imgBanner: UIImageView!
    @IBOutlet var imgPoster: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbTime: UILabel!
    @IBOutlet var lbRate: UILabel!
    @IBOutlet var lbViewer: UILabel!
    @IBOutlet var lbStatus: UILabel!
    @IBOutlet var lbCode: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lbView: UILabel!
    
    private var movieId = 0
    var movieDetail : MovieDetail? = nil
    var movieFunc = ["About", "Cast", "Comment","Review", "Recommend"]
    
    let pagingViewController = PagingViewController()
    
    func initData(movieId: Int){
        self.movieId = movieId
    }
    
    var aboutViewController : UIViewController?
    
    override func viewDidLoad() {
        //request data
        fetchMovieDetail(movieId: movieId)
        
        //init pagingview
        pagingViewController.dataSource = self
        
        //        pagingViewController.register(MovieFuncPagingCell.self, for: PagingIndexItem.self)
        pagingViewController.selectedTextColor = .white
        pagingViewController.textColor = .lightGray
        pagingViewController.font = UIFont.boldSystemFont(ofSize: 17)
        pagingViewController.selectedFont = UIFont.boldSystemFont(ofSize: 17)
        pagingViewController.menuItemLabelSpacing = 15
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 80, height: 58)
    
        pagingViewController.indicatorOptions = .hidden
        pagingViewController.select(index: 0)
        pagingViewController.menuBackgroundColor = UIColor(red: 21/255, green: 48/255, blue: 87/255, alpha: 1)
        
        //insert view
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: lbView.bottomAnchor)
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func injectData(movie: MovieDetail){
        loadImage(link: movie.backdrop_path!, view: self.imgBanner)
        loadImage(link: movie.poster_path!, view: self.imgPoster)
        lbTitle.text = movie.title
        lbTime.text = movie.release_date
        lbViewer.text = String(movie.vote_count!)
        lbRate.text = String(movie.vote_average!)
        lbStatus.text = movie.status
        setGradient(imageView: imgBanner)
    }
    
    func setGradient(imageView: UIImageView){
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        let startColor = UIColor(red: 30/255, green: 113/255, blue: 79/255, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]
        imageView.layer.insertSublayer(gradient, at: 0)
    }
}

extension MovieDetailViewController {
    
    static let URL_MOVIE_POPULAR = "https://api.themoviedb.org/3/movie/"
    static let PARAMETER_MOVIE_REQUEST: Parameters = [
        "api_key": "aa26b8d5bb328940b3887aefecf302e0"
    ]
    
    func fetchMovieDetail(movieId: Int){
        let request = AF.request(
            MovieDetailViewController.URL_MOVIE_POPULAR+String(movieId),
            parameters: MovieDetailViewController.PARAMETER_MOVIE_REQUEST,
            encoding: URLEncoding(destination: .queryString))
        
        request.responseString { [self] temp in
            let result = temp.result
            do {
                let jsonString = try result.get()
                let movieDetail = Mapper<MovieDetail>().map(JSONString: jsonString)
                self.movieDetail = movieDetail
                self.injectData(movie: movieDetail!)
                pagingViewController.reloadData()
            } catch {
                
            }
        }
    }
    
    func loadImage(link: String, view: UIImageView){
        
        let poster = "https://image.tmdb.org/t/p/original/"+link
        guard let url = URL.init(string: poster) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                view.image = value.image
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

extension MovieDetailViewController: PagingViewControllerDataSource {
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        movieFunc.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controller : UIViewController
        switch index {
        case 0:
            controller = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            (controller as! AboutViewController).initData(movieDetail: self.movieDetail)
        case 1:
            controller = storyboard.instantiateViewController(withIdentifier: "CastViewController") as! CastViewController
            (controller as! CastViewController).initData(movieId: self.movieId)
        case 3:
            controller = storyboard.instantiateViewController(withIdentifier: "RecommendViewController") as! RecommendViewController
            (controller as! RecommendViewController).initData(movieId: self.movieId)
        default:
            controller = ContentViewController(title: "init later")
        }
        return controller
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        //        return MovieFuncItem(title: movieFunc[index], index: index)
        return PagingIndexItem(index: index, title: movieFunc[index])
    }
}
