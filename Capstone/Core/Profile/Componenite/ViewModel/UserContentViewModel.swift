//
//  UserContentViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import Foundation

@MainActor
class UserContentViewModel: ObservableObject {
    @Published var threads = [Thread]()
    @Published var replies = [CapReply]()
    let user: User
   
    init(user: User) {
        self.user = user
        // we do this so they all excuted at the same time
        Task { try await fetchUserThreads() }
        Task { try await fetchUserReply() }

    }
    
    
    /// get  threads data for a user
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchCurrentUserThreads(by: user.id)
        for index in threads.indices {
            threads[index].user  = self.user
        }
        self.threads = threads
    }
    
    
    
    // get user thread reply data for a user
    func fetchUserReply() async throws {
        self.replies = try await ThreadReplyService.fetchThreadRepliesCurrentUser(forUser: user)
        try await fetchReplyThreadData()
    }
    
    
    func fetchReplyThreadData() async throws  {
        for index in replies.indices {
            let reply = replies[index]
            
            var thread = try await ThreadService.fetchThread(threadId: reply.threadId)
            thread.user = try await UserService.fetchUser(withUid: thread.ownerUid)
            
            replies[index].thread = thread
        }
    }
}
