//
//  ResultView.swift
//  aioutfitchecker
//
//  Result Screen (Post Analysis)
//

import SwiftUI

struct FeedbackItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let iconName: String
}

struct ResultView: View {
    let outfit: Outfit
    let analyzedImage: UIImage?
    let onDismiss: () -> Void
    @Environment(\.dismiss) var dismiss
    
    // Mock data matching the design
    private let mockScore: Double = 8.5
    private let mockSummary: String = "Excellent Color Harmony"
    private let mockPros: [FeedbackItem] = [
        FeedbackItem(
            title: "Proportions",
            description: "Great silhouette management with the fitted top and relaxed coat.",
            iconName: "chart.bar.fill"
        )
    ]
    private let mockRefinements: [FeedbackItem] = [
        FeedbackItem(
            title: "Footwear Choice",
            description: "Consider a darker boot to anchor the look more solidly.",
            iconName: "shoe.fill"
        )
    ]
    private let mockStylistSuggestion: String = "Add a structured leather handbag in a deep emerald tone. It will elevate the outfit's premium feel and add a subtle pop of color without overwhelming the neutral palette."
    
    private var displayImage: UIImage? {
        analyzedImage ?? (outfit.imageData.flatMap { UIImage(data: $0) })
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Score Section
                    VStack(spacing: 8) {
                        Text("\(mockScore, specifier: "%.1f")")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundColor(Color(red: 34/255, green: 197/255, blue: 94/255))
                        
                        Text("/ 10")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                        
                        Text(mockSummary)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                            .padding(.top, 4)
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                    
                    // Outfit Image with improved visibility
                    if let uiImage = displayImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 420)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                            .padding(.horizontal, 20)
                            .padding(.bottom, 32)
                    } else {
                        // Placeholder for mock
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.2))
                            .frame(maxWidth: .infinity)
                            .frame(height: 420)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 48))
                                    .foregroundColor(.gray)
                            )
                            .padding(.horizontal, 20)
                            .padding(.bottom, 32)
                    }
                    
                    // Pros Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(red: 34/255, green: 197/255, blue: 94/255))
                                .font(.system(size: 20))
                            Text("Pros")
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .padding(.horizontal, 20)
                        
                        // Recheck Outfit Button
                        Button(action: {
                            // Recheck action
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Recheck Outfit")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(red: 37/255, green: 99/255, blue: 235/255))
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        
                        // Pros Cards
                        ForEach(mockPros) { pro in
                            FeedbackCard(
                                title: pro.title,
                                description: pro.description,
                                iconName: pro.iconName
                            )
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 32)
                    
                    // Refinements Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 8) {
                            Image(systemName: "sparkles")
                                .foregroundColor(Color(red: 251/255, green: 146/255, blue: 60/255))
                                .font(.system(size: 20))
                            Text("Refinements")
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .padding(.horizontal, 20)
                        
                        // Refinement Cards
                        ForEach(mockRefinements) { refinement in
                            FeedbackCard(
                                title: refinement.title,
                                description: refinement.description,
                                iconName: refinement.iconName
                            )
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 32)
                    
                    // Stylist Suggestion Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "hanger")
                                .font(.system(size: 24))
                                .foregroundColor(Color(red: 96/255, green: 165/255, blue: 250/255))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("STYLIST SUGGESTION")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                Text("\"\(mockStylistSuggestion)\"")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.white)
                                    .lineSpacing(4)
                            }
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 22/255, green: 45/255, blue: 135/255))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                        onDismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Analysis Result")
                        .font(.system(size: 18, weight: .semibold))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Share action
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 17))
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct FeedbackCard: View {
    let title: String
    let description: String
    let iconName: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    ResultView(
        outfit: Outfit(
            occasion: .casual,
            score: 85,
            positivePoints: ["Colors complement well"],
            improvementPoints: ["Consider adding accessories"],
            suggestion: "Try adding a watch"
        ),
        analyzedImage: nil
    ) {
        // Preview dismiss handler
    }
}
