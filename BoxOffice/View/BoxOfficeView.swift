//
//  BoxOfficeView.swift
//  BoxOffice
//
//  Created by 최서희 on 8/20/24.
//

import SwiftUI

struct BoxOfficeView: View {
    @Binding var selectedTab: Int
    @State var selectedDate: Date = Date.lastWeek
    @State var selectedIndex: Int = 0
    @State var showingSheet = false
    @State var selectedItem: Int?
    
    let weekType: [String] = ["주간", "주말"]
    
    @StateObject var boxOfficeViewModel = BoxOfficeViewModel()
    @StateObject var movieInfoViewModel = MovieInfoViewModel()
    @StateObject var moviePosterViewModel = MoviePosterViewModel()
    @StateObject var movieViewModel: MovieViewModel
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        let boxOfficeVM = BoxOfficeViewModel()
        let movieInfoVM = MovieInfoViewModel()
        let moviePosterVM = MoviePosterViewModel()
        self._boxOfficeViewModel = StateObject(wrappedValue: boxOfficeVM)
        self._movieInfoViewModel = StateObject(wrappedValue: movieInfoVM)
        self._moviePosterViewModel = StateObject(wrappedValue: moviePosterVM)
        self._movieViewModel = StateObject(wrappedValue: MovieViewModel(boxOfficeViewModel: boxOfficeVM, movieInfoViewModel: movieInfoVM, moviePosterViewModel: moviePosterVM))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Picker("Week", selection: $selectedIndex) {
                    ForEach(0..<weekType.count, id: \.self) { index in
                        Text(weekType[index])
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
                .onChange(of: selectedIndex) {
                    DispatchQueue.main.async {
                        movieViewModel.loadAllData(targetDt: selectedDate, weekGb: String(selectedIndex))
                    }}
                DatePicker("", selection: $selectedDate, in: Date.distantPast...Date.lastWeek, displayedComponents: [.date])
                    .onChange(of: selectedDate) {
                        DispatchQueue.main.async {
                            movieViewModel.loadAllData(targetDt: selectedDate, weekGb: String(selectedIndex))
                        }
                    }
            }
            .padding(.horizontal, 30)
            
            if movieViewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                NavigationView {
                    List {
                        ForEach(movieViewModel.movies.indices, id: \.self) { index in
                            Button(action: {
                                self.selectedItem = index
                            }) {
                                VStack {
                                    MovieListView(movieIndex: index)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                .sheet(item: $selectedItem) { index in
                    MovieDetailView(movieIndex: index)
                }
                .environmentObject(movieViewModel)
            }
        }
        .onAppear {
            movieViewModel.loadAllData(targetDt: selectedDate, weekGb: String(selectedIndex))
        }
    }
}

#Preview {
    BoxOfficeView(selectedTab: .constant(0))
}


