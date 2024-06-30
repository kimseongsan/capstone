//
//  ThreadDetailViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/15/24.
//

import Foundation

@MainActor
class CapdDetailViewModel: ObservableObject {
    @Published var replies = [CapReply]()
    
    private let thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
        Task { try await fetchThreadReplies() }
    }
    

    private func fetchThreadReplies() async throws {
        self.replies = try await CapReplyService.fetchThreadReplies(forThread: thread)
        try await fetchUserDataForReplies()
    }
    
    
    private func fetchUserDataForReplies() async throws {
        for index in replies.indices {
            let reply = replies[index]
            
            async let user = try await UserService.fetchUser(withUid: reply.threadReplyOwnerUid)
            self.replies[index].replyUser = try await user
        }
    }
}
