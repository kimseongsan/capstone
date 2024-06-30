import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 16) {
            CircleProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.username)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                // 액션 버튼에 필요한 동작을 추가하세요.
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    UserCell(user: dev.user)
}
