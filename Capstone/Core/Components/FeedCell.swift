//
//  ThreadCell.swift
//  Threads Clone
//
//  Created by Garrett Hanberg on 9/3/23.
//

import SwiftUI

struct FeedCell: View {
    let welfare: Thread
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(user: welfare.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(welfare.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            // Action for ellipsis button
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    
                    Text(welfare.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 2)
                }
            }
            .padding(.vertical, 8)
            
            Divider()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(welfare: dev.thread)
    }
}
