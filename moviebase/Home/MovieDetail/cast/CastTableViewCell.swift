//
//  CastTableViewCell.swift
//  moviebase
//
//  Created by NguyenKhacDat on 14/05/2021.
//

import UIKit
import Kingfisher

class CastTableViewCell: UITableViewCell {
    
    @IBOutlet var imgAvatar: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbName: UILabel!
    
    func injectData(cast: Cast){
        roundedImage()
        lbTitle.text = cast.name
        lbName.text = cast.original_name
        loadImage(link: cast.profile_path ?? "", view: imgAvatar)
    }
    
    func roundedImage(){
        imgAvatar.layer.borderWidth = 1
        imgAvatar.layer.masksToBounds = false
        imgAvatar.layer.borderColor = UIColor.black.cgColor
        imgAvatar.layer.cornerRadius = imgAvatar.frame.height/2
        imgAvatar.clipsToBounds = true
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
