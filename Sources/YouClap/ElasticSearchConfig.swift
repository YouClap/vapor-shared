import Foundation

public struct ElasticSearchConfig {
    let hostname: String
    let port: Int

    public init(hostname: String, port: Int) {
        self.hostname = hostname
        self.port = port
    }
}
