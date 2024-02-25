import Foundation
import Supabase
class SignUpViewModel: ObservableObject {
    @Published var shouldNavigate = false
    @Published var errorMessage: String?
    @Published var userId: String = ""

    func signUp(email: String, password: String, username: String) {
        Task {
            do {
                let response = try await supabase.auth.signUp(email: email, password: password)
                print("User signed up: \(response.user.email ?? "unknown")")

                let userId = response.user.id.uuidString
                DispatchQueue.main.async {
                    self.userId = userId
                    self.shouldNavigate = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                print("Error signing up: \(error)")
            }
        }
    }

}

