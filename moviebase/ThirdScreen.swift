//
//  SecondScreenController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 10/05/2021.
//

import UIKit
import Parchment


class ThirdScreen : UIViewController{
    
    let cities = [
        "Oslo",
        "Stockholm",
        "Tokyo",
        "Barcelona",
        "Vancouver",
        "Berlin"
    ]
    
    
    let pagingViewController = PagingViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        pagingViewController.register(MoviePagingCell.self, for: CalendarItem.self)
//        pagingViewController.menuItemSize = .fixed(width: 70, height: 70)
//        pagingViewController.textColor = UIColor.gray
//
//        pagingViewController.dataSource = self
//        pagingViewController.register(MoviePagingCell.self, for: CalendarItem.self)
//        pagingViewController.select(index: 0)
//        addChild(pagingViewController)
//        view.addSubview(pagingViewController.view)
//        pagingViewController.didMove(toParent: self)
//        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
//
//
//        NSLayoutConstraint.activate([
//            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
//        ])
        
    }
}
//extension ThirdScreen: PagingViewControllerDataSource {
//    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
//        return ContentViewController(title: "dat")
//    }
//
//    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
//        return CalendarItem(date: Date().addingTimeInterval(86400))
//    }
//
//    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
//        return cities.count
//    }
//}

struct CalendarItem: PagingItem, Hashable, Comparable {
    let date: Date
    let dateText: String
    let weekdayText: String
    
    init(date: Date) {
        self.date = date
        dateText = "Dat"
        weekdayText = ""
    }
    
    static func < (lhs: CalendarItem, rhs: CalendarItem) -> Bool {
        return lhs.date < rhs.date
    }
}
