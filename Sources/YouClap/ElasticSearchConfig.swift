import Foundation

public struct ElasticSearchConfig {
    public let hostname: String
    public let port: Int

    public init(hostname: String, port: Int) {
        self.hostname = hostname
        self.port = port
    }
}
