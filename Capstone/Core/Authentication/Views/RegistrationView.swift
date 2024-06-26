//
//  RegistrationView.swift
//  Threads Clone
//
//  Created by Garrett Hanberg on 9/2/23.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()

            
            VStack(spacing: 24) {
                TextField("당신의 이메일을 입력해주세요.", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(CapTextFieldModelifier())
                
                SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                    .modifier(CapTextFieldModelifier())
                
                TextField("당신의 이름을 입력해주세요", text: $viewModel.fullname)
                    .modifier(CapTextFieldModelifier())
                
                TextField("당신의 닉네임을 입력해주세요", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(CapTextFieldModelifier())
            }
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("이미 계정이 있으신 가요?")
                    
                    Text("로그인")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
