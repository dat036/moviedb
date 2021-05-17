//
//  HomeController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 06/05/2021.
//

import UIKit
import Alamofire

class HomeController: UIViewController {
    @IBOutlet var tableview: UITableView!
}

extension HomeController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
                as? HomeMovieCell else {fatalError("Unable Cell")}
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
