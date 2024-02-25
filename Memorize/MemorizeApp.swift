import SwiftUI
import Supabase

@main
struct MemorizeApp: App {
    init() {
    }
    
    var body: some Scene {
        WindowGroup {
              NavigationView {
                  DemographicsFormView(userId: "4da5f51e-461e-4076-a919-d31a937597c2")
              }
          }
    }
}
