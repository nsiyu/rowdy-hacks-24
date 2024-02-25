import Foundation
import Supabase

class LoginViewModel: ObservableObject {
    @Published var showLoadingIndicator = false
    @Published var showErrorBanner = false
    @Published var shouldNavigate = false
    @Published var userId: String = ""

    func login(email: String, password: String) {
        showLoadingIndicator = true
        Task {
            do {
                let response = try await supabase.auth.signIn(email: email, password: password)
                print("User logged in: \(response.user.email ?? "unknown")")
                DispatchQueue.main.async {
                    self.showLoadingIndicator = false
                    self.userId = response.user.id.uuidString
                    self.shouldNavigate = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.showLoadingIndicator = false
                    self.showErrorBanner = true
                }
                print("Error logging in: \(error)")
            }
        }
        
    }
}

