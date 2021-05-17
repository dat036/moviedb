//
//  MovieViewCellTableViewCell.swift
//  moviebase
//
//  Created by NguyenKhacDat on 10/05/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    weak var delegate: CollectionCellDelegate?

    @IBOutlet var trendingLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    
    var movieCollectionData = Array<Movie>()

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureData(trending: String, category: String, listMovie: Array<Movie>){
        trendingLabel.text = trending
        categoryLabel.text = category
        movieCollectionData = listMovie
        collectionview.reloadData()
    }
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { fatalError("Unable to create table view cell")}
        cell.configureData(movie: movieCollectionData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onSelectedItem(movieId: movieCollectionData[indexPath.row].id!)
    }
}

protocol CollectionCellDelegate: AnyObject {
    func onSelectedItem(movieId : Int)
}
