import SwiftUI

struct PhotoPreviewView: View {
    var photo: UIImage
    var dismissAction: () -> Void
    var navigateToReportView: (String) -> Void

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
                Button(action: {
                    classifier.classify(image: photo) { classification in
                        navigateToReportView(classification)
                    }
                }) {
                    Text("Analyze")
                        .font(.headline)
                        .foregroundColor(.white)
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
