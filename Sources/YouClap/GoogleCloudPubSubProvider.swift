import GoogleCloudKit
import GoogleCloudPubSubKit
import Vapor

public final class GoogleCloudPubSubProvider: Provider {

    public init() {}

    public func register(_ s: inout Services) {
        s.register(PublisherClient.self) { container throws -> PublisherClient in
            let googleConfiguration = try container.make(GoogleCloudCredentialsConfiguration.self)
            let pubSubConfiguration = try container.make(PubSubConfiguration.self)

            return try PublisherClient.client(configuration: googleConfiguration,
                                              pubSubConfiguration: pubSubConfiguration,
                                              eventLoop: container.eventLoop)
        }
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

extension PublisherClient: Service {}
