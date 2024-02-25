import SwiftUI
import Supabase

@main
struct MemorizeApp: App {
    init() {
    }
    
    var body: some Scene {
        WindowGroup {
              NavigationView {
                  StartPageView()
              }
          }
    }
}
