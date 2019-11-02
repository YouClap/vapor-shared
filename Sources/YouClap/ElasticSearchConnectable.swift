import Vapor

public final class ElasticSearchConnectable {

    private let container: Container
    private let config: ElasticSearchConfig

    public init(container: Container, config: ElasticSearchConfig) {
        self.container = container
        self.config = config
    }

    public func post<E>(_ path: String, content: E) -> Future<HTTPResponse> where E: Encodable {
        do {
            let contentCoders = try container.make(ContentCoders.self)

            let jsonEncoder = try contentCoders.requireDataEncoder(for: .json)
            let data = try jsonEncoder.encode(content)

            var request = HTTPRequest(method: .POST, url: path, body: data)
            request.contentType = .json

            return client()
                .flatMap { $0.send(request) }
        } catch {
            return container.future(error: error)
        }
    }

    public func put<E>(_ path: String, content: E) -> Future<HTTPResponse> where E: Encodable {
        do {
            let contentCoders = try container.make(ContentCoders.self)

            let jsonEncoder = try contentCoders.requireDataEncoder(for: .json)
            let data = try jsonEncoder.encode(content)

            var request = HTTPRequest(method: .PUT, url: path, body: data)
            request.contentType = .json

            return client()
                .flatMap { $0.send(request) }
        } catch {
            return container.future(error: error)
        }
    }

    // MARK: - Private Methods

    private func  client() -> Future<HTTPClient> {
        return HTTPClient.connect(hostname: config.hostname, port: config.port, on: container)
    }
}
