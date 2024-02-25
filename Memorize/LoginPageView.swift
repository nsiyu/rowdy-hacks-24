import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.95, blue: 1.0)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.darkBlue)

                if viewModel.showErrorBanner {
                    Text("Invalid Credentials")
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(5)
                }

                VStack(spacing: 5) {
                    VStack(alignment: .leading, spacing: 5) {
                        InputLabel(title: "Email")
                        TextField("", text: $username)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.darkGray)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )

                        InputLabel(title: "Password")
                        SecureField("", text: $password)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.darkGray)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }

                if viewModel.showLoadingIndicator {
                    ProgressView()
                        .padding()
                } else {
                    Button("Login") {
                        viewModel.login(email: username, password: password)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.darkBlue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Spacer().frame(height: 20)

                Text("Or login with")
                    .font(.caption)
                    .foregroundColor(.darkBlue)

                VStack {
                    SignUpSocialButton(logo: "googleLogo", title: "Google", color: .white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .cornerRadius(10)

                    Spacer().frame(height: 20)

                    SignUpSocialButton(logo: "facebookLogo", title: "Facebook", color: .blue)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            
            NavigationLink("", destination: MainView(userId: viewModel.userId), isActive: $viewModel.shouldNavigate)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
