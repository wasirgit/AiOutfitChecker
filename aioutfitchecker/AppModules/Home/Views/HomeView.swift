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
    @State private var showAnalysis = false
    @State private var showResult = false
    
    let occasions = Occasion.allCases
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Photo Upload Area
                    VStack(spacing: 12) {
                        Text("PHOTO UPLOAD")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if let image = viewModel.selectedImage {
                            // Selected Photo Preview
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                        } else {
                            // Upload Placeholder
                            VStack(spacing: 16) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 200)
                                    .overlay(
                                        VStack(spacing: 8) {
                                            Image(systemName: "camera.fill")
                                                .font(.system(size: 40))
                                                .foregroundColor(.gray)
                                            Text("Tap to upload photo")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    )
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                                    )
                                
                                HStack(spacing: 20) {
                                    // Camera Button
                                    Button(action: {
                                        showImagePicker = true
                                    }) {
                                        HStack {
                                            Image(systemName: "camera")
                                            Text("Camera")
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }
                                    
                                    // Gallery Button
                                    Button(action: {
                                        showImagePicker = true
                                    }) {
                                        HStack {
                                            Image(systemName: "photo.on.rectangle")
                                            Text("Gallery")
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Occasion Selector
                    VStack(alignment: .leading, spacing: 12) {
                        Text("OCCASION")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ForEach(occasions, id: \.self) { occasion in
                                Button(action: {
                                    viewModel.selectOccasion(occasion)
                                }) {
                                    Text(occasion.rawValue)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                            viewModel.selectedOccasion == occasion
                                                ? Color.gray.opacity(0.3)
                                                : Color.gray.opacity(0.1)
                                        )
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(
                                                    viewModel.selectedOccasion == occasion
                                                        ? Color.gray
                                                        : Color.gray.opacity(0.5),
                                                    lineWidth: viewModel.selectedOccasion == occasion ? 2 : 1
                                                )
                                        )
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Primary CTA Button
                    Button(action: {
                        if viewModel.canCheckOutfit {
                            showAnalysis = true
                        }
                    }) {
                        Text("CHECK OUTFIT")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                viewModel.canCheckOutfit
                                    ? Color.gray.opacity(0.3)
                                    : Color.gray.opacity(0.1)
                            )
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                    .disabled(!viewModel.canCheckOutfit)
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
                .padding(.top)
            }
            .navigationTitle("Home")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $viewModel.selectedImage, sourceType: .photoLibrary)
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
                    ResultView(outfit: result) {
                        viewModel.reset()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
