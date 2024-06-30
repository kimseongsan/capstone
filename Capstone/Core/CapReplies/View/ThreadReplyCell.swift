//
//  ThreadReplyCell.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/15/24.
//

import SwiftUI

struct ThreadReplyCell: View {
    let reply: CapReply
    
    private var user: User? {
        return reply.replyUser
    }
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 12) {
                CircleProfileImageView(user: user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(reply.timestamp.timestampString())
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        })
                    }
                    
                    Text(reply.replyText)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
//                    ContentActionButtonView(thread: thread)
//                        .foregroundStyle(Color(.black))
//                        .padding(.vertical, 8)
                }
            }
            Divider()
        }.padding()
    }
}

#Preview {
    ThreadReplyCell(reply: dev.reply)
}
