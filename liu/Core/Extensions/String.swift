import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: LocalizationService.shared.bundle, value: "", comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}

