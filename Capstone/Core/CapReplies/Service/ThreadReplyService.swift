//
//  ThreadReplyService.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadReplyService {
    static func uploadThreadReply(_ reply: CapReply, forThread thread: Thread) async throws {
        
        guard let replyData = try? Firestore.Encoder().encode(reply) else { return }
        async let _ = try await FirestoreConstants.RepliesCollection.document().setData(replyData)
        async let _ = try await FirestoreConstants.ThreadCollection.document(thread.id).updateData([ "replyCount" : thread.replyCount + 1 ])
    }
    
    
    static func fetchThreadReplies(forThread thread: Thread) async throws -> [CapReply] {
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField("threadId", isEqualTo: thread.id)
            .getDocuments()
        
        let threadReplies = snapshot.documents.compactMap({ try? $0.data(as: CapReply.self)})
        return threadReplies.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()})
    }
    
    
    static func fetchThreadReplies(forUser user: User) async throws -> [CapReply] {
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField("threadOwnerUid", isEqualTo: user.id)
            .getDocuments()
        
        let threadReplies = snapshot.documents.compactMap({ try? $0.data(as: CapReply.self)})
        return threadReplies.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()})
    }
    
    static func fetchThreadRepliesCurrentUser(forUser user: User) async throws -> [CapReply] {
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField("threadReplyOwnerUid", isEqualTo: user.id)
            .getDocuments()
        
        var replies = snapshot.documents.compactMap({ try? $0.data(as: CapReply.self)})
       
        for index in replies.indices {
            replies[index].replyUser = user
        }
        return replies
    }
}
