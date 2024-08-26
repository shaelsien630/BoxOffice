//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import Foundation

class BoxOfficeViewModel: ObservableObject {
    func fetchBoxOfficeList(targetDt: Date, weekGb: String, completion: @escaping (Result<BoxOfficeResult, Error>) -> Void) {
        let boxOfficeURL = KobisBoxOiifce(key: Bundle.main.kobisApiKey ?? "", targetDt: targetDt.toString(format: .yyyyMMdd), weekGb: weekGb).getBoxOfficeURL()
        
        if let url = URL(string: boxOfficeURL) {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    let statusCodeError = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : "Status code: \(httpResponse.statusCode)"])
                    completion(.failure(statusCodeError))
                    return
                }
                
                if let dataReceived = data {
                    do {
                        let decodedList = try JSONDecoder().decode(BoxOfficeResponse.self, from: dataReceived)
                        completion(.success(decodedList.boxOfficeResult))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                }
            }
            dataTask.resume()
        }
    }
    
    func convert(boxOffice: BoxOffice) -> Movie {
        return Movie(
            code: boxOffice.movieCd,
            name: boxOffice.movieNm,
            openDate: boxOffice.openDt.asDate() ?? Date(),
            boxOfficeInfo: BoxOfficeInfo(
                rank: Int(boxOffice.rank) ?? 0,
                rankInten: Int(boxOffice.rankInten) ?? 0,
                rankOldAndNew: boxOffice.rankOldAndNew,
                audienceAccumulation: Int(boxOffice.audiAcc) ?? 0
            )
        )
    }
}
