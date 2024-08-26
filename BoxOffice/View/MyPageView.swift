//
//  MyPageView.swift
//  BoxOffice
//
//  Created by 최서희 on 8/20/24.
//

import SwiftUI

struct MyPageView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        Text("리뷰를 관리할 수 있는 마이페이지 입니다")
    }
}

#Preview {
    MyPageView(selectedTab: .constant(1))
}
