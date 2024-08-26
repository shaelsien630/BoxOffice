//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import Foundation

struct MovieInfoResponse: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Codable {
    let movieCd: String
    let movieNm: String
    let movieNmEn: String
    let movieNmOg: String
    let showTm: String
    let prdtYear: String
    let openDt: String
    let prdtStatNm: String
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staffs]
}

struct Nation: Codable {
    let nationNm: String
}

struct Genre: Codable {
    let genreNm: String
}

struct Director: Codable {
    let peopleNm: String
    let peopleNmEn: String
}

struct Actor: Codable {
    let peopleNm: String
    let peopleNmEn: String
    let cast: String
    let castEn: String
}

struct ShowType: Codable {
    let showTypeGroupNm: String
    let showTypeNm: String
}

struct Company: Codable {
    let companyCd: String
    let companyNm: String
    let companyNmEn: String
    let companyPartNm: String
}

struct Audit: Codable {
    let auditNo: String
    let watchGradeNm: String
}

struct Staffs: Codable {
    let peopleNm: String
    let peopleNmEn: String
    let staffRoleNm: String
}
