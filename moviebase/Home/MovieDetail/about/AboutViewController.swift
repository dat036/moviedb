//
//  AboutViewController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 14/05/2021.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet var lbContent: UILabel!
    @IBOutlet var lbReadMore: UIButton!
    @IBOutlet var collectionGenre: UICollectionView!
    
    var movieDetail : MovieDetail? = nil
    var listGenre = Array<Genres>()
    
    func initData(movieDetail : MovieDetail?){
        self.movieDetail = movieDetail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if movieDetail != nil {
            self.listGenre = (movieDetail?.genres)!
        }
        collectionGenre.delegate = self
        collectionGenre.dataSource = self
        
        lbContent.text = movieDetail?.overview
    }
}

extension AboutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionGenre.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as? GenreCollectionViewCell else { fatalError("Unable to create table view cell")}
        cell.label.text = listGenre[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGenre.count
        
    }
}

