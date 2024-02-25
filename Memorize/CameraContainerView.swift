import SwiftUI
import SwiftyCam

struct CameraView: UIViewControllerRepresentable {
    var cameraViewController: SwiftyCamViewController
    @Binding var capturedPhoto: UIImage?

    func makeUIViewController(context: Context) -> SwiftyCamViewController {
        cameraViewController.cameraDelegate = context.coordinator
        cameraViewController.shouldUseDeviceOrientation = false
        cameraViewController.allowAutoRotate = false
        cameraViewController.defaultCamera = .rear
        cameraViewController.videoGravity = .resizeAspectFill
        cameraViewController.pinchToZoom = false
        cameraViewController.swipeToZoom = false
        return cameraViewController
    }

    func updateUIViewController(_ uiViewController: SwiftyCamViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, SwiftyCamViewControllerDelegate {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
            parent.capturedPhoto = photo
        }
    }
}

// MARK: - CameraControlsView
struct CameraControlsView: View {
    @Binding var capturedImage: UIImage?
    var cameraViewController: SwiftyCamViewController

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    cameraViewController.takePhoto()
                }) {
                    ZStack {
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 4)
                            .background(Circle().fill(Color.white.opacity(0.2)))
                            .frame(width: 70, height: 70)

                        Circle()
                            .fill(Color.white)
                            .frame(width: 45, height: 45)
                    }
                }
                Spacer()
            }
            .padding(.bottom, 40)
        }
    }
}

// MARK: - MainCameraView
struct MainCameraView: View {
    @State private var cameraViewController = SwiftyCamViewController()
    @State private var capturedPhoto: UIImage?
    @State private var isPhotoPreviewPresented = false
    @State private var isReportViewPresented = false

    var body: some View {
        NavigationView {
            ZStack {
                CameraView(cameraViewController: cameraViewController, capturedPhoto: $capturedPhoto)
                    .edgesIgnoringSafeArea(.all)
                CameraControlsView(capturedImage: $capturedPhoto, cameraViewController: cameraViewController)
            }
            .fullScreenCover(isPresented: $isPhotoPreviewPresented) {
                if let photo = capturedPhoto {
                    PhotoPreviewView(photo: photo, dismissAction: {
                        isPhotoPreviewPresented = false
                    }, navigateToReportView: { _ in
                        isPhotoPreviewPresented = false
                        isReportViewPresented = true
                    })
                }
            }
            .fullScreenCover(isPresented: $isReportViewPresented) {
                ReportView()
            }
            .onChange(of: capturedPhoto) { _ in
                isPhotoPreviewPresented = capturedPhoto != nil
            }
        }
    }
}



struct MainCameraView_Previews: PreviewProvider {
    static var previews: some View {
        MainCameraView()
    }
}
