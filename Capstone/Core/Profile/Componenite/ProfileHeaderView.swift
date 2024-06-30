//
//  ProfileHeaderView.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    var body: some View {
        // Profile Image
        HStack(alignment: .top) {
            // For Bio and stats
            VStack(alignment: .leading, spacing: 12) {
                
                // Full name and username
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.fullname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user?.username ?? "")
                        .font(.subheadline)
                }
                
                if let bio = user?.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            Spacer()
            CircleProfileImageView(user: user, size: .large)
        }
        .padding()
    }
}

#Preview {
    ProfileHeaderView(user: dev.user)
}
