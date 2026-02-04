//
//  SettingsView.swift
//  aioutfitchecker
//
//  Wireframe: Settings Tab - Minimal Sections
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                // Account / App Info Section
                Section {
                    SettingsRow(title: "Account", detail: "Guest User")
                    SettingsRow(title: "App Version", detail: viewModel.appVersion)
                } header: {
                    Text("APP INFO")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Usage Limits Section
                Section {
                    SettingsRow(title: "Usage Plan", detail: viewModel.usagePlan.rawValue)
                    SettingsRow(title: "Checks Remaining", detail: "\(viewModel.checksRemaining) / \(viewModel.totalChecks)")
                } header: {
                    Text("USAGE LIMITS")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Support Section
                Section {
                    Button(action: {}) {
                        SettingsRow(title: "Feedback", detail: nil)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {}) {
                        SettingsRow(title: "Support", detail: nil)
                    }
                    .buttonStyle(.plain)
                } header: {
                    Text("SUPPORT")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Legal Section
                Section {
                    Button(action: {}) {
                        SettingsRow(title: "Privacy Policy", detail: nil)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {}) {
                        SettingsRow(title: "Terms of Service", detail: nil)
                    }
                    .buttonStyle(.plain)
                } header: {
                    Text("LEGAL")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsRow: View {
    let title: String
    let detail: String?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            
            Spacer()
            
            if let detail = detail {
                Text(detail)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            if detail == nil {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SettingsView()
}
