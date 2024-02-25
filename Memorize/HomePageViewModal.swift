import Foundation
import Supabase

class HomePageViewModel: ObservableObject {
    @Published var username: String = ""
    
    func fetchUserData(userId: String) {
        Task {
            do {
                struct User: Decodable {
                    let name: String
                    let user_id: String
                }
                let user: User = try await supabase.database.from("User").select().eq("user_id", value:userId).single().execute().value
                DispatchQueue.main.async {
                    self.username = user.name
                }
            } catch {
                print("Error fetching user data: \(error)")
            }
        }
    }

    
}
