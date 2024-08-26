//
//  MovieInfoViewModel.swift
//  BoxOffice
//
//  Created by 최서희 on 8/20/24.
//

import Foundation

class MovieInfoViewModel: ObservableObject {
    func fetchMovieInfo(movieCd: String, completion: @escaping (Result<MovieInfoResult, Error>) -> Void) {
        let movieInfoURL = KobisMovieInfo(key: Bundle.main.kobisApiKey ?? "", movieCd: movieCd).getMovieInfoURL()
        
        if let url = URL(string: movieInfoURL) {
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
                        let decodedList = try JSONDecoder().decode(MovieInfoResponse.self, from: dataReceived)
                        completion(.success(decodedList.movieInfoResult))
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
    
    func convert(movieInfo: MovieInfo) -> MovieDetailInfo {
        return MovieDetailInfo(
            movieNameEnglish: movieInfo.movieNmEn,
            showTime: Int(movieInfo.showTm) ?? 0,
            productionYear: movieInfo.prdtYear,
            genres: movieInfo.genres.map { $0.genreNm },
            directors: movieInfo.directors.map { $0.peopleNm },
            actors: movieInfo.actors.map { $0.peopleNm } ,
            audit: movieInfo.audits.first?.watchGradeNm ?? ""
        )
    }
}
