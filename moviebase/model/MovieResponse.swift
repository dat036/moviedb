//
//  MovieResponse.swift
//  moviebase
//
//  Created by NguyenKhacDat on 10/05/2021.
//

import Foundation
import ObjectMapper

struct MovieResponse : Mappable , Codable {
    var page : Int?
    var results : [Movie]?
    var total_pages : Int?
    var total_results : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        page <- map["page"]
        results <- map["results"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
    }

}
