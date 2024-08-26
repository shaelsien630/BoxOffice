//
//  MovieListView.swift
//  BoxOffice
//
//  Created by 최서희 on 8/20/24.
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    var movieIndex: Int
    
    var body: some View {
        HStack(spacing: 20) {
            // 순위, NEW/OLD/등락
            VStack(alignment:.center, spacing: 20) {
                Text(String(movieViewModel.movies[movieIndex].boxOfficeInfo.rank))
                    .font(.title)
                    .bold()
                
                let oldAndNew = movieViewModel.movies[movieIndex].boxOfficeInfo.rankOldAndNew
                let rankInten = movieViewModel.movies[movieIndex].boxOfficeInfo.rankInten
                if oldAndNew == "NEW" {
                    Text(oldAndNew)
                } else { // OLD
                    if rankInten > 0 {
                        HStack(spacing: 3) {
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundStyle(.red)
                            Text(String(rankInten))
                        }
                    } else if rankInten < 0 {
                        HStack(spacing: 3) {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundStyle(.blue)
                            Text(String(rankInten * -1))
                        }
                    } else {
                        Text("-")
                    }
                }
            }
            .frame(width: 50)
            
            // 영화제목, 개봉일, 관객수
            VStack(alignment:.leading, spacing: 5) {
                Text(movieViewModel.movies[movieIndex].name)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.accentColor)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.leading)
                
                Text("개봉일 \((movieViewModel.movies[movieIndex].openDate).toString(format: .yyyyMMddDot))")
                Text("관객수 \(movieViewModel.movies[movieIndex].boxOfficeInfo.audienceAccumulation) 명")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // 영화 포스터
            if let posterURLString = movieViewModel.movies[movieIndex].movieDetailInfo?.poster,
               let posterURL = URL(string: posterURLString) {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // 로딩 중
                            .frame(width: 80, height: 120)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 120)
                    case .failure(_):
                        Rectangle()
                            .foregroundColor(.secondary)
                            .frame(width: 80, height: 120)
                    @unknown default:
                        Rectangle()
                            .foregroundColor(.secondary)
                            .frame(width: 80, height: 120)
                    }
                }
            } else {
                Rectangle()
                    .foregroundColor(.secondary)
                    .frame(width: 80, height: 120)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("BackgroundColor"))
                .stroke(Color.accentColor, lineWidth: 2)
        )
    }
}

#Preview {
    let boxOfficeViewModel = BoxOfficeViewModel()
    let movieInfoViewModel = MovieInfoViewModel()
    let moviePosterViewModel = MoviePosterViewModel()
    
    let movieViewModel = MovieViewModel(
        boxOfficeViewModel: boxOfficeViewModel,
        movieInfoViewModel: movieInfoViewModel,
        moviePosterViewModel: moviePosterViewModel
    )
    
    return MovieListView(movieIndex: 0)
        .environmentObject(movieViewModel)
}
