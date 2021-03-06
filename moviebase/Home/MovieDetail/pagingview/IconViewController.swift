//
//  IconViewController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 14/05/2021.
//
import UIKit

class IconViewController: UIViewController {
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title

        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.thin)
        label.textColor = UIColor(red: 95 / 255, green: 102 / 255, blue: 108 / 255, alpha: 1)
        label.text = title.capitalized
        label.sizeToFit()

        view.addSubview(label)
//        view.addConstraint(view.centerXAnchor.constraint(equalTo: label.centerXAnchor))
//        view.addConstraint(        view.centerYAnchor.constraint(equalTo: label.centerYAnchor)
//)
//        view.backgroundColor = .white
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
