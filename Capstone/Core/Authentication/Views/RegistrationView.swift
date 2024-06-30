import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isSigningUp = false // Track whether sign-up is in progress
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                TextField("이메일을 입력하세요", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.none)
                
                SecureField("비밀번호를 입력하세요", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                TextField("이름을 입력하세요", text: $viewModel.fullname)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                TextField("사용자 이름을 입력하세요", text: $viewModel.username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.none)
            }
            .padding(.horizontal, 32)
            
            Button(action: {
                Task {
                    isSigningUp = true
                    try await viewModel.createUser()
                    isSigningUp = false
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(viewModel.areFieldsEmpty() ? Color(.systemGray4) : Color.blue)
                        .frame(height: 44)
                    
                    if isSigningUp {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(.white)
                    } else {
                        Text("회원가입")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            })
            .disabled(viewModel.areFieldsEmpty())
            .padding(.top, 20)
            .padding(.horizontal, 32)
            
            Spacer()
            
            Divider()
                .padding(.vertical, 20)
            
            Button(action: {
                dismiss()
            }, label: {
                HStack(spacing: 4) {
                    Text("이미 계정이 있습니까?")
                    Text("로그인")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundColor(.blue)
            })
            .padding(.bottom, 30)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RegistrationView()
}
