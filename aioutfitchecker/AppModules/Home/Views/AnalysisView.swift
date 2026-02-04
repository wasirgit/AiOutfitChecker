//
//  AnalysisView.swift
//  aioutfitchecker
//
//  Wireframe: Analysis/Loading State
//

import SwiftUI

struct AnalysisView: View {
    let selectedOccasion: String
    let onComplete: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Loading Indicator
            ProgressView()
                .scaleEffect(2.0)
            
            // Status Text
            VStack(spacing: 8) {
                Text("ANALYZING OUTFIT...")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Please wait while we analyze your outfit")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .task {
            // Wait for analysis to complete
            onComplete()
        }
    }
}

#Preview {
    AnalysisView(selectedOccasion: "Casual") {
        // Preview completion handler
    }
}
