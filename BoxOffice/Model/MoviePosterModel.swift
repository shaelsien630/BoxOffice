//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import Foundation

struct MoviePoster: Codable {
    let response: String
    let poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case response = "Response"
        case poster = "Poster"
    }
}
