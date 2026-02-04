//
//  String+Extensions.swift
//  AIOutfitChecker
//
//  Extensions: String helper extensions
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        String(format: self.localized, arguments: arguments)
    }
}
