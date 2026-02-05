//
//  HomeView.swift
//  aioutfitchecker
//
//  Wireframe: Home Tab - Main User Flow
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showAnalysis = false
    @State private var showResult = false
    
    let occasions = Occasion.allCases
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Check Your Look")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 20)
                .padding(.bottom, 20)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Main Card / Photo Preview
                    ZStack {
                        if let image = viewModel.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 420)
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 32)
                                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                                )
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        } else {
                            // Upload Placeholder Card
                            VStack(spacing: 24) {
                                Circle()
                                    .fill(Color.blue.opacity(0.05))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "hanger")
                                            .font(.system(size: 44, weight: .light))
                                            .foregroundColor(.blue)
                                    )
                                
                                VStack(spacing: 12) {
                                    Text("Upload your outfit")
                                        .font(.system(size: 22, weight: .bold))
                                    
                                    Text("Get instant AI feedback on your style.\nWe analyze color, fit, and trends.")
                                        .font(.system(size: 15))
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 30)
                                        .lineSpacing(4)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 420)
                            .background(
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: 2, dash: [6, 6]))
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Occasion Selector
                    VStack(alignment: .leading, spacing: 16) {
                        Text("SELECT OCCASION")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 32)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(occasions, id: \.self) { occasion in
                                    Button(action: {
                                        viewModel.selectOccasion(occasion)
                                    }) {
                                        Text(occasion.rawValue)
                                            .font(.system(size: 14, weight: .medium))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 12)
                                            .background(
                                                viewModel.selectedOccasion == occasion
                                                    ? Color.blue
                                                    : Color.gray.opacity(0.08)
                                            )
                                            .foregroundColor(
                                                viewModel.selectedOccasion == occasion
                                                    ? .white
                                                    : .primary
                                            )
                                            .cornerRadius(25)
                                    }
                                }
                            }
                            .padding(.horizontal, 32)
                        }
                    }
                    
                    Spacer(minLength: 20)
                }
            }
            
            // Bottom Action Buttons
            VStack(spacing: 16) {
                if viewModel.selectedImage != nil {
                     // Check Outfit Button (Only shown when image is selected)
                     Button(action: {
                         if viewModel.canCheckOutfit {
                             showAnalysis = true
                         }
                     }) {
                         Text("Analyze Outfit")
                             .font(.system(size: 17, weight: .bold))
                             .foregroundColor(.white)
                             .frame(maxWidth: .infinity)
                             .frame(height: 60)
                             .background(
                                 RoundedRectangle(cornerRadius: 20)
                                     .fill(viewModel.canCheckOutfit ? Color.blue : Color.blue.opacity(0.5))
                             )
                             .shadow(color: Color.blue.opacity(0.2), radius: 10, y: 5)
                     }
                     .disabled(!viewModel.canCheckOutfit)
                     .padding(.horizontal, 24)
                     .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                // Take Photo Button
                Button(action: {
                    sourceType = .camera
                    showImagePicker = true
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "camera.fill")
                        Text("Take Photo")
                    }
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 22/255, green: 45/255, blue: 135/255).opacity(0.9),
                                Color(red: 37/255, green: 99/255, blue: 235/255)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.2), radius: 10, y: 5)
                }
                .padding(.horizontal, 24)
                
                // Gallery Button
                Button(action: {
                    sourceType = .photoLibrary
                    showImagePicker = true
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "photo.fill")
                        Text("Upload from Gallery")
                    }
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.15), lineWidth: 1.5)
                    )
                }
                .padding(.horizontal, 24)
            }
            .padding(.top, 20)
            .padding(.bottom, 24)
            .background(Color.white)
        }
        .background(Color(red: 248/255, green: 250/255, blue: 252/255).ignoresSafeArea())
        .animation(.spring(), value: viewModel.selectedImage)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $viewModel.selectedImage, sourceType: sourceType)
        }
        .fullScreenCover(isPresented: $showAnalysis) {
            AnalysisView(selectedOccasion: viewModel.selectedOccasion?.rawValue ?? "") {
                Task {
                    await viewModel.checkOutfit()
                    showAnalysis = false
                    if viewModel.analysisResult != nil {
                        showResult = true
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showResult) {
            if let result = viewModel.analysisResult {
                ResultView(
                    outfit: result,
                    analyzedImage: viewModel.selectedImage
                ) {
                    viewModel.reset()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
