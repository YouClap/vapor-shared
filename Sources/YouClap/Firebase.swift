import Foundation

public enum Firebase {
    private static let identifierLength = 20
    private static let identifierAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    private static var randomGenerator = SystemRandomNumberGenerator()

    public static var autoIdentifier: String {
        return String((0..<Self.identifierLength).compactMap { _ -> Character? in
            return Self.identifierAlphabet.randomElement(using: &Self.randomGenerator)
        })
    }
}
