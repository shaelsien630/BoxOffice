//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by 최서희 on 8/20/24.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    var movieIndex: Int
    
    var body: some View {
        VStack {
            // 포스터
            AsyncImage(url: URL(string: movieViewModel.movies[movieIndex].movieDetailInfo?.poster ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 300)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.secondary)
                    .frame(width: 200, height: 300)
            }
            .padding()
            
            VStack {
                // 영화 제목
                Text(movieViewModel.movies[movieIndex].name)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 2)
                    .foregroundColor(Color.accentColor)
                
                // 개봉연도, 상영시간, 관람연령
                HStack(spacing: 10) {
                    Text("\(String(describing: movieViewModel.movies[movieIndex].movieDetailInfo!.productionYear))")
                    Text("\(movieViewModel.movies[movieIndex].movieDetailInfo?.showTime ?? 0)분")
                    Text(movieViewModel.movies[movieIndex].movieDetailInfo?.audit ?? "전체관람가")
                }
                .font(.headline)
                .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            // 별점
            
            Divider()
            
            HStack(spacing: 40) {
                VStack(spacing: 8) {
                    // 박스오피스 순위 + 문구
                    Text("\(movieViewModel.movies[movieIndex].boxOfficeInfo.rank)위")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.accentColor)
                    Text("박스오피스")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                VStack(spacing: 8) {
                    // 누적관객수 + 문구
                    Text("\(movieViewModel.movies[movieIndex].boxOfficeInfo.audienceAccumulation.formatted())명")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.accentColor)
                    Text("누적 관객수")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 30) {
                    Text("장르")
                        .bold()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 60, alignment: .leading)
                    Text(movieViewModel.movies[movieIndex].movieDetailInfo?.genres.joined(separator: ", ") ?? "")
                    Spacer()
                }
                HStack(spacing: 30) {
                    Text("감독")
                        .bold()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 60, alignment: .leading)
                    Text(movieViewModel.movies[movieIndex].movieDetailInfo?.directors.joined(separator: ", ") ?? "")
                    Spacer()
                }
                HStack(spacing: 30) {
                    Text("주연")
                        .bold()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 60, alignment: .leading)
                    Text(movieViewModel.movies[movieIndex].movieDetailInfo?.actors.joined(separator: ", ") ?? "")
                    // .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    // Spacer()
                }
                HStack(spacing: 30) {
                    Text("제작연도")
                        .bold()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 60, alignment: .leading)
                    Text(movieViewModel.movies[movieIndex].movieDetailInfo?.productionYear ?? "")
                    Spacer()
                }
            }
            .font(.headline)
            .padding(.vertical)
            .padding(.horizontal, 16)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
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
    
    return MovieDetailView(movieIndex: 0)
        .environmentObject(movieViewModel)
}
