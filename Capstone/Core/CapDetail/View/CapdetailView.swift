//
//  ThreadDetailView.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/15/24.
//

import SwiftUI

struct CapDetailView: View {
    @StateObject var viewModel : CapdDetailViewModel
    let thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
        self._viewModel = StateObject(wrappedValue: CapdDetailViewModel(thread: thread))
    }
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CircularProfileImageView(user: thread.user, size: .small)
                    
                    Text(thread.user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(thread.timestamp.timestampString())
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray3))
                    
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.darkGray))
                    })
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(thread.caption)
                        .font(.subheadline)
                    
                    ContentActionButtonView(thread: thread)
                }.frame(maxWidth: .infinity , alignment: .leading)
            }
            
            Divider()
                .padding(.vertical)
            
            LazyVStack {
                ForEach(viewModel.replies) { reply in
                    CapReplyCell(reply: reply)
                }
            }
            
            
            
        }
        .padding()
        .scrollIndicators(.hidden)
        .navigationTitle("Thread")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CapDetailView(thread: dev.thread)
}
