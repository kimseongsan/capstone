//
//  EditProfileView.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/13/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let user: User
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    @Environment(\.dismiss) var dismiss
    @State private var isLoading = false
    
    
    @StateObject var viewModel = EidtProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    //Name and profile Image
                    HStack {
                        VStack (alignment: .leading){
                            Text("이름")
                                .fontWeight(.semibold)
                            Text(user.fullname)
                            
                        }
                        Spacer()
                        PhotosPicker(selection: $viewModel.selectedItem) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircleProfileImageView(user: user, size: .small)
                            }
                        }
                        
                    }
                    Divider()
                    
                    //Bio Field
                    VStack (alignment: .leading){
                        Text("Bio")
                            .fontWeight(.semibold)
                        TextField("Enter your Bio ...", text: $bio, axis: .vertical)
                        
                    }
                    Divider()
                    
                    //Link Field
                    VStack (alignment: .leading){
                        Text("Link")
                            .fontWeight(.semibold)
                        TextField("Add Link...", text: $link, axis: .vertical)
                        
                    }
                    Divider()
                    
                    Toggle("Private Profile", isOn: $isPrivateProfile)
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
                
                
            }
            .navigationTitle("프로필 수정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") { dismiss() }
                        .font(.subheadline)
                        .foregroundStyle(Color(.black))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        isLoading = true
                        Task {
                            try await viewModel.updateUserData()
                            isLoading = false
                            dismiss()
                        }
                        
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.black))
                }
            }
            .overlay(
                Group {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(.black)
                    }
                }
            )
        }
       
    }
}

#Preview {
    EditProfileView(user: dev.user)
}
