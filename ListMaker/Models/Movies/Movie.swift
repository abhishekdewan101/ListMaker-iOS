//
//  Movie.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/17/22.
//

import Foundation

struct MovieList : Decodable {
    let results : [Movie]
}

struct Movie : Decodable {
    let title: String?
    let posterPath: String?
    let id: Int
    let name: String?
    
    var quailifiedPosterPath: String? {
        "https://image.tmdb.org/t/p/w500/\(posterPath ?? "")"
    }
}
