//
//  CircleProfileImage.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimention: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        }
    }
}



struct CircleProfileImageView: View {
    var user : User?
    var size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimention , height: size.dimention)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Color(.systemGray4), lineWidth: 1.0)
                }
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: size.dimention, height:  size.dimention)
                .foregroundStyle(Color(.systemGray4))
                .overlay {
                    Circle().stroke(Color(.systemGray4), lineWidth: 1.0)
                }
        }
    }
}

#Preview {
    CircleProfileImageView(user: dev.user, size: .small)
}
