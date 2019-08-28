public extension ElasticSearchConfig {
    static func loadFromEnvironment() -> ElasticSearchConfig? {
        guard
            let hostname = Environment.get("ELASTICSEARCH_HOSTNAME"),
            let portAsString = Environment.get("ELASTICSEARCH_PORT"),
            let port = Int(portAsString)
            else { return nil }

        return ElasticSearchConfig(hostname: hostname, port: port)
    }
}
