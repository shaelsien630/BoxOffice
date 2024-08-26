//
//  MoviePosterViewModel.swift
//  BoxOffice
//
//  Created by 최서희 on 8/23/24.
//

import Foundation

class MoviePosterViewModel: ObservableObject { 
    func fetchMoviePoster(title: String, completion: @escaping (Result<String, Error>) -> Void) {
        let moviePosterURL = OmdbMoviePoster(key: Bundle.main.omdbApiKey ?? "", title: title).getMoviePosterURL()
        if let url = URL(string: moviePosterURL) {
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
                        let decodedList = try JSONDecoder().decode(MoviePoster.self, from: dataReceived)
                        completion(.success(decodedList.poster ?? ""))
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
}
