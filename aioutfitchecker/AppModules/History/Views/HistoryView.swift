//
//  HistoryView.swift
//  aioutfitchecker
//
//  Wireframe: History Tab - Past Results
//

import SwiftUI

struct HistoryView: View {
    @State private var viewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.historyItems.isEmpty {
                    // Empty State
                    VStack(spacing: 16) {
                        Image(systemName: "clock")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("No History")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Your outfit checks will appear here")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // History List
                    List {
                        ForEach(viewModel.historyItems) { item in
                            HistoryRow(item: item)
                                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("History")
        }
    }
}

struct HistoryRow: View {
    let item: HistoryItem
    
    var body: some View {
        Button(action: {
            // Navigate to full result
        }) {
            HStack(spacing: 16) {
                // Outfit Thumbnail
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                // Details
                VStack(alignment: .leading, spacing: 8) {
                    // Score
                    HStack(spacing: 4) {
                        Text("\(item.score)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("/ 100")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Occasion
                    Text(item.occasion.rawValue.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    // Date
                    Text(item.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HistoryView()
}
