//
//  MovieCollectionViewCell.swift
//  moviebase
//
//  Created by NguyenKhacDat on 11/05/2021.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell : UICollectionViewCell{
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    func configureData(movie: Movie){
        titleLabel.text = movie.title ?? "nil"
        rateLabel.text = String(format: "%.1f", movie.vote_average ?? 0)
        
        let poster = "https://image.tmdb.org/t/p/original/"+movie.poster_path!
        guard let url = URL.init(string: poster) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                self.posterImageView.image = value.image
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
