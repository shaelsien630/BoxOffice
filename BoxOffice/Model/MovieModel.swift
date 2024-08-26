//
//  MovieModel.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import Foundation

struct Movie {
    let code: String                // 영화코드
    let name: String                // 영화명
    let openDate: Date              // 개봉일
    var boxOfficeInfo: BoxOfficeInfo
    var movieDetailInfo: MovieDetailInfo?
}

struct BoxOfficeInfo {
    let rank: Int                   // 박스오피스 순위
    let rankInten: Int              // 전일대비 순위 증감분
    let rankOldAndNew: String       // 랭킹 신규진입여부
    let audienceAccumulation: Int   // 누적관객수
}

struct MovieDetailInfo {
    let movieNameEnglish: String    // 영화명(영문)
    let showTime: Int               // 상영시간
    let productionYear: String      // 제작연도
    let genres: [String]            // 장르
    let directors: [String]         // 감독
    let actors: [String]            // 배우
    let audit: String               // 심의정보
    var poster: String?             // 영화 포스터
}
