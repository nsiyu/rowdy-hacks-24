import SwiftUI

struct PhotoPreviewView: View {
    var photo: UIImage
    var dismissAction: () -> Void
    var navigateToReportView: (String) -> Void
    
    @State private var isAnalyzing = false // State to manage loading indicator
    
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
                        // Simulate a delay for the analyzing process
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            classifier.classify(image: photo) { classification in
                                navigateToReportView(classification)
                                isAnalyzing = false // Stop analyzing
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
