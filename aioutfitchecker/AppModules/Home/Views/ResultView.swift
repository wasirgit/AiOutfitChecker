//
//  ResultView.swift
//  aioutfitchecker
//
//  Wireframe: Result Screen (Post Analysis)
//

import SwiftUI

struct ResultView: View {
    let outfit: Outfit
    let onDismiss: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Outfit Score (Prominent)
                    VStack(spacing: 8) {
                        Text("OUTFIT SCORE")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(outfit.score)")
                            .font(.system(size: 72, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("/ 100")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)
                    
                    // Positive Points
                    VStack(alignment: .leading, spacing: 16) {
                        Text("POSITIVE POINTS")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(outfit.positivePoints, id: \.self) { point in
                                HStack(alignment: .top, spacing: 12) {
                                    Text("•")
                                        .font(.title3)
                                    Text(point)
                                        .font(.body)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    // Improvement Points
                    VStack(alignment: .leading, spacing: 16) {
                        Text("IMPROVEMENT POINTS")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(outfit.improvementPoints, id: \.self) { point in
                                HStack(alignment: .top, spacing: 12) {
                                    Text("•")
                                        .font(.title3)
                                    Text(point)
                                        .font(.body)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    // Improvement Suggestion
                    VStack(alignment: .leading, spacing: 12) {
                        Text("SUGGESTION")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(outfit.suggestion)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    
                    // Actions
                    VStack(spacing: 12) {
                        Button(action: {
                            dismiss()
                            onDismiss()
                        }) {
                            Text("RECHECK OUTFIT")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                        }
                        
                        Button(action: {
                            dismiss()
                            onDismiss()
                        }) {
                            Text("BACK TO HOME")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle("Result")
            .navigationBarTitleDisplayMode(.inline)
        }
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
        )
    ) {
        // Preview dismiss handler
    }
}
