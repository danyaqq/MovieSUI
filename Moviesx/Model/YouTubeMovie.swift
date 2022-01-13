//
//  YouTubeMovie.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import Foundation


struct YouTubeMovieResponse: Codable{
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IdVideElement
}

struct IdVideElement: Codable{
    let kind: String
    let videoId: String
}

