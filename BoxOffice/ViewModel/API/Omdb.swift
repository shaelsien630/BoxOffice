//
//  Omdb.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import Foundation


struct OmdbMoviePoster {
    let baseURL = "https://www.omdbapi.com/"
    let key: String
    let title: String
        
    func getMoviePosterURL() -> String {
        return baseURL + "?apikey=" + key + "&t=" + title
    }
}
