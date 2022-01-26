import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
