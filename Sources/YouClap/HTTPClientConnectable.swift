import Vapor

public final class HTTPClientConnectable {
    private let container: Container

    public init(container: Container) {
        self.container = container
    }

    public func get(url baseURL: URLRepresentable, queryItems: [URLQueryItem]?) -> Future<HTTPResponse> {
        do {
            guard
                let baseURL = baseURL.convertToURL(),
                var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
            else {
                return container.eventLoop.newFailedFuture(error: Error.url)
            }

            queryItems.flatMap { urlComponents.queryItems = (urlComponents.queryItems ?? []) + $0 }

            guard let url = urlComponents.url else {
                return container.eventLoop.newFailedFuture(error: Error.url)
            }

            let client = try container.client()

            return client.get(url)
                .mapError(Error.request)
                .map { $0.http }
        } catch {
            return container.eventLoop.newFailedFuture(error: error)
        }
    }
}

extension HTTPClientConnectable {
    public enum Error: Swift.Error {
        case baseURL
        case url
        case request(Swift.Error)
    }
}
