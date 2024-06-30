//
//  ExploreView.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/12/24.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel = ExploreViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.users) { user in
                        NavigationLink(value: user) {
                            VStack {
                                UserCell(user: user)
                                Divider()
                                    .padding(.horizontal)
                            }.padding(.vertical, 4)
                        }
                    }
                }
                .navigationDestination(for: User.self) { user in
                    ProfileView(user: user)
                }
            }
            .toolbar(.visible, for: .tabBar)
            .navigationTitle("검색")
            .searchable(text: $searchText, prompt: "검색해주세요")
           

        }
    }
}

#Preview {
    ExploreView()
}
