//
//  ThreadRepliesViewModel.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import Foundation
import Firebase

class CapRepliesViewModel: ObservableObject {
    
    func uploadThreadReply(_ replyText: String, thread:Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let reply = CapReply(
            threadId: thread.id,
            replyText: replyText,
            threadReplyOwnerUid: uid,
            threadOwnerUid: thread.ownerUid,
            timestamp: Timestamp())
        
        try await CapReplyService.uploadCapReply(reply, forThread: thread)
        
    }
}
