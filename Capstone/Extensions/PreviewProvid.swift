//
//  PreviewProvider.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import Foundation
import Firebase

let dev = _PreviewProvider()
class _PreviewProvider {
    let user = User(id: NSUUID().uuidString, fullname: "Hardi", email: "hardi@gmail.com", username: "hardi19")
    
    var thread: Thread {
        return Thread(threadId: NSUUID().uuidString ,
                      ownerUid: "",
                      caption: "The shortest war in history.",
                      timestamp: Timestamp(),
                      likes: 34, replyCount: 5,
                      user: user)
    }
    
    lazy var reply = CapReply(
        replyId: "",
        threadId: "",
        replyText: "Cool this is really cool",
        threadReplyOwnerUid: "",
        threadOwnerUid: "",
        timestamp: Timestamp(),
        thread: thread,
        replyUser: user)
}

