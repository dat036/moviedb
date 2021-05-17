//
//  SecondViewController.swift
//  moviebase
//
//  Created by NguyenKhacDat on 14/05/2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    private var x: String = "dat123 "
    override func viewDidLoad() {
        print("init ne`")
        label.text = x
    }
}
