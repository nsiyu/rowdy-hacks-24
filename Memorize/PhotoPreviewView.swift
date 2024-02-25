import SwiftUI
import CoreLocation

struct PhotoPreviewView: View {
    var photo: UIImage
    var dismissAction: () -> Void
    var navigateToReportView: (String) -> Void
    
    @State private var isAnalyzing = false // State to manage loading indicator
    @StateObject private var locationManager = LocationManager() // Location manager
    
    private let classifier = CoreMLClassifier()

    var body: some View {
        ZStack {
            Image(uiImage: photo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Spacer()
                    Button(action: dismissAction) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding([.trailing, .top], 30)
                    }
                }
                Spacer()
                
                if isAnalyzing {
                    // Show loading indicator while analyzing
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                } else {
                    // Show the "Analyze" button when not analyzing
                    Button(action: {
                        isAnalyzing = true // Start analyzing
                        locationManager.requestLocation { success in
                            if success {
                                // Location obtained, you can use locationManager.lastLocation here
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    classifier.classify(image: photo) { classification in
                                        navigateToReportView(classification)
                                        isAnalyzing = false // Stop analyzing
                                    }
                                }
                            } else {
                                // Handle location error or denied access
                                isAnalyzing = false
                                // Optionally, navigate to an error view or show an alert
                            }
                        }
                    }) {
                        Text("Analyze")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Capsule().fill(Color.lightGreen))
                            .shadow(color: .darkBlue.opacity(0.3), radius: 5, x: 0, y: 3)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation(completion: @escaping (Bool) -> Void) {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            completion(true)
        } else {
            completion(false) // Location services are not enabled
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
