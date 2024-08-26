//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import Foundation

struct BoxOfficeResponse: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String?
    let yearWeekTime: String
    let weeklyBoxOfficeList: [BoxOffice]
}

struct BoxOffice: Codable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}
