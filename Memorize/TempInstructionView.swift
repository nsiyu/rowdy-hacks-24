//
//  TempInstructionView.swift
//  Memorize
//
//  Created by Nicolas Huang on 2/25/24.
//

import SwiftUI
import SwiftyCam

// MARK: - MainCameraView
struct TempInstructionView: View {
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
                CameraInstructionOverlayView(instructionText: "Take a picture of this part", instructionImage: Image("throat"))
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

// MARK: - CameraInstructionOverlayView
struct CameraInstructionOverlayView: View {
    var instructionText: String
    var instructionImage: Image

    var body: some View {
        VStack {
            VStack {
                
                Text(instructionText)
                    .foregroundColor(.white)
                    .font(.headline)
                instructionImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(8)
            Spacer()
        }
        .padding()
    }
}

// MARK: - MainCameraView
struct TempMainCameraView: View {
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
                CameraInstructionOverlayView(instructionText: "Take a picture of this part", instructionImage: Image("throat"))
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
