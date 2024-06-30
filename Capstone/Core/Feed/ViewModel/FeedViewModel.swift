//
//  FeedViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    init() {
        Task { try await fetchThreads() }
    }
    
    
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThreads()
        try await fetchUserDataForThread()
    }
    
    
//    private func fetchUserDataForThread() async  throws{
//        for i in 0 ..< threads.count {
//            let thread = threads[i]
//            let ownerUid = thread.ownerUid
//            let threadUser =  try await UserService.fetchUser(withUid: ownerUid)
//            threads[i].user = threadUser
//        }
//    }
    /// When using for thread in threads {}, the thread variable is a constant let variable, so you cannot modify the threads array by assigning a new value to thread.
    private func fetchUserDataForThread() async throws {
        for index in threads.indices {
            let thread = threads[index]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            threads[index].user = threadUser
        }
    }
}
