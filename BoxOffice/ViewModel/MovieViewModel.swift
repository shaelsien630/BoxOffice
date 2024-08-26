//
//  MovieViewModel.swift
//  BoxOffice
//
//  Created by 최서희 on 8/20/24.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var movies: [Movie] = []
    
    var boxOfficeViewModel: BoxOfficeViewModel
    var movieInfoViewModel: MovieInfoViewModel
    var moviePosterViewModel: MoviePosterViewModel
    
    init(boxOfficeViewModel: BoxOfficeViewModel, movieInfoViewModel: MovieInfoViewModel, moviePosterViewModel: MoviePosterViewModel) {
        self.boxOfficeViewModel = boxOfficeViewModel
        self.movieInfoViewModel = movieInfoViewModel
        self.moviePosterViewModel = moviePosterViewModel
        
        movies = [ // Sample Data
            Movie(
                code: "001",
                name: "The Swift Adventure",
                openDate: Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 15))!,
                boxOfficeInfo: BoxOfficeInfo(
                    rank: 1,
                    rankInten: 0,
                    rankOldAndNew: "NEW",
                    audienceAccumulation: 1200000
                ),
                movieDetailInfo: MovieDetailInfo(
                    movieNameEnglish: "The Swift Adventure",
                    showTime: 120,
                    productionYear: "2023",
                    genres: ["Action", "Adventure"],
                    directors: ["John Doe"],
                    actors: ["Jane Smith", "John Appleseed"],
                    audit: "PG-13",
                    poster: "https://m.media-amazon.com/images/M/MV5BYzE5MjY1ZDgtMTkyNC00MTMyLThhMjAtZGI5OTE1NzFlZGJjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"
                )
            )
        ]
    }
    
    func loadAllData(targetDt: Date, weekGb: String) {
        self.isLoading = true
        boxOfficeViewModel.fetchBoxOfficeList(targetDt: targetDt, weekGb: weekGb) { [self] result in
            switch result {
            case .success(let boxOfficeResult):
                // print("Box Office List loaded successfully.")
                movies = boxOfficeResult.weeklyBoxOfficeList.map { boxOfficeViewModel.convert(boxOffice: $0) }
                // 모든 영화 정보를 비동기로 가져오기 위해 async를 사용
                Task {
                    for (index, boxOffice) in boxOfficeResult.weeklyBoxOfficeList.enumerated() {
                        await processFetch(movieCd: boxOffice.movieCd, index: index)
                    }
                    // 모든 작업이 완료되면 isLoading을 false로 설정
                    DispatchQueue.main.async {
                        print("All Data Fetch successfully.")
                        self.isLoading = false
                    }
                }
            case .failure(let error):
                print("Failed to load Box Office List: \(error.localizedDescription)")
            }
        }
    }
    
    func processFetch(movieCd: String, index: Int) async {
        // print("Fetching movie info for movieCd: \(movieCd)")
        await withCheckedContinuation { continuation in
            movieInfoViewModel.fetchMovieInfo(movieCd: movieCd) { [self] result in
                switch result {
                case .success(let movieInfoResult):
                    // print("\(index) MovieInfo loaded successfully.")
                    movies[index].movieDetailInfo = movieInfoViewModel.convert(movieInfo: movieInfoResult.movieInfo)
                    Task {
                        await processFetch2(title: movieInfoResult.movieInfo.movieNmEn, index: index)
                        continuation.resume()
                    }
                case .failure(let error):
                    print("Failed to load MovieInfo: \(error.localizedDescription)")
                    continuation.resume()
                }
            }
        }
    }
    
    func processFetch2(title: String, index: Int) async {
        // print("Fetching movie poster for title: \(title)")
        await withCheckedContinuation { continuation in
            moviePosterViewModel.fetchMoviePoster(title: title) { [self] result in
                switch result {
                case .success(let posterURL):
                    // print("\(index) MoviePoster loaded successfully.")
                    movies[index].movieDetailInfo?.poster = posterURL
                case .failure(let error):
                    print("Failed to load MoviePoster: \(error.localizedDescription)")
                }
                continuation.resume()
            }
        }
    }
}
