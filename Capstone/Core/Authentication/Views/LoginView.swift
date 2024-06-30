import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var isSigningIn = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                VStack(spacing: 16) {
                    TextField("이메일을 입력해주세요", text: $viewModel.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.none)
                    
                    SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 32)
                
                Button(action: {
                    Task {
                        isSigningIn = true
                        try await viewModel.login()
                        isSigningIn = false
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(viewModel.areFieldsEmpty() ? Color(.systemGray4) : Color.blue)
                            .frame(height: 44)
                        
                        if isSigningIn {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(.white)
                        } else {
                            Text("로그인")
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
                
                NavigationLink {
                    RegistrationView()
                } label: {
                    HStack(spacing: 4) {
                        Text("계정이 없으신가요?")
                        Text("회원가입")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundColor(.blue)
                }
                .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
