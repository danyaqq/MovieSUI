//
//  Movie.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import Foundation

//All movies
struct ResultMovies: Hashable, Codable{
    let results: [Movie]
}

//Movie model
struct Movie: Hashable, Codable, Identifiable{
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
