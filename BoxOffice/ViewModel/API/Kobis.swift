//
//  Kobis.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import Foundation

struct KobisBoxOiifce {
    let boxOfficePath = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json"
    let key: String
    let targetDt: String
    let weekGb: String
    
    func getBoxOfficeURL() -> String {
        return boxOfficePath + "?key=" + key + "&targetDt=" + targetDt + "&weekGb=" + weekGb
    }
}

struct KobisMovieInfo {
    let movieInfoPath = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    let key: String
    let movieCd: String
    
    func getMovieInfoURL() -> String {
        return movieInfoPath + "?key=" + key + "&movieCd=" + movieCd
    }
}
