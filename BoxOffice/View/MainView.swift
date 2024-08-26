//
//  MainView.swift
//  BoxOffice
//
//  Created by 최서희 on 8/19/24.
//

import SwiftUI

struct MainView: View {
    @State var pageNumber: Int = 0
    
    var body: some View {
        VStack {
            Text("Popular Movie List")
                .font(.title)
                .bold()
                .italic()
                .foregroundColor(.white)
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
            
            TabView(selection: $pageNumber, content:  {
                BoxOfficeView(selectedTab: $pageNumber)
                    .tabItem {
                        Image(systemName: "movieclapper")
                        Text("BoxOffice")
                    }
                    .tag(0)
                
                MyPageView(selectedTab: $pageNumber)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("MyPage")
                    }
                    .tag(1)
            })
            .ignoresSafeArea(edges: .bottom)
            .accentColor(Color.accentColor)
            .padding(.top, 10)
        }
    }
}

#Preview {
    MainView()
}
