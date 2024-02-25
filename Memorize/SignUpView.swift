import Supabase
import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.95, blue: 1.0)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.darkBlue)

                    VStack(spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            InputLabel(title: "Username")
                            TextField("", text: $username)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.darkGray)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.darkGray, lineWidth: 1)
                                )

                            InputLabel(title: "Email")
                            TextField("", text: $email)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.darkGray)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.darkGray, lineWidth: 1)
                                )

                            InputLabel(title: "Password")
                            SecureField("", text: $password)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.darkGray)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.darkGray, lineWidth: 1)
                                )
                        }
                    }

                    HStack {
                        Spacer()
                        Text("Or sign up with")
                            .font(.caption)
                            .foregroundColor(.darkBlue)
                        Spacer()
                    }
                    Spacer().frame(height: 15)

                    VStack {
                        SignUpSocialButton(logo: "googleLogo", title: "Google", color: .white)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .cornerRadius(10)

                        Spacer().frame(height: 20)

                        SignUpSocialButton(logo: "facebookLogo", title: "Facebook", color: .blue)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .cornerRadius(10)
                    }

                    Spacer().frame(height: 20)

                    Button("Sign Up") {
                        viewModel.signUp(email: email, password: password, username: username)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.darkBlue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Spacer()
                    NavigationLink("", destination: DemographicsFormView(userId:  viewModel.userId), isActive: $viewModel.shouldNavigate)
                }
                .padding()
                .padding(.bottom, keyboardHeight)
                .onAppear {
                    registerForKeyboardNotifications()
                }
            }
        }
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            keyboardHeight = keyboardFrame.height - (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


struct InputLabel: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.darkBlue)
    }
}

struct SignUpSocialButton: View {
    let logo: String
    let title: String
    let color: Color

    var body: some View {
        HStack(alignment: .center) {
            Image(logo)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)

            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(color)
        .cornerRadius(10)
    }
}

extension Color {
    static let darkBlue = Color(red: 0.1, green: 0.2, blue: 0.3)
    static let titleBackgroundColor = Color(red: 0.8, green: 0.9, blue: 1.0)
    static let darkGray = Color(red: 0.4, green: 0.4, blue: 0.4)
    static let lightGreen = Color(red: 0.88, green: 0.96, blue: 0.88)
    static let backGroundColor = Color(red: 0.9, green: 0.95, blue: 1.0)
}

