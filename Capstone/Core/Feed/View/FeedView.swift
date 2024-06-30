//
//  FeedView.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/12/24.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                LazyVStack {
                    ForEach(viewModel.threads) { thread in
                        NavigationLink(value: thread) {
                            ThreadCell(thread: thread)
                        }
                    }
                }
            }
            .refreshable {
//                print("DEBUG: Refresh threads")
                Task { try await viewModel.fetchThreads() }
            }
            .navigationDestination(for: Thread.self, destination: { thread in
                DetailView(thread: thread)
            })
            .navigationTitle("홈")
            .navigationBarTitleDisplayMode(.inline)
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(Color(.black))
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
