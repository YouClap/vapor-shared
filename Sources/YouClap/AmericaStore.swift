import Foundation
import GoogleCloudPubSubKit
import NIO

public protocol AmericaStore: Service {
    var messageQueueClient: PublisherClient { get }

    func publish(messages: AmericaMessage...) -> EventLoopFuture<PublishResponse>
    func publish(messages: [AmericaMessage]) -> EventLoopFuture<PublishResponse>
}

extension AmericaStore {
    private var topic: ProjectTopic { ProjectTopic(project: messageQueueClient.project, name: "america") }

    public func publish(messages: AmericaMessage...) -> EventLoopFuture<PublishResponse> {
        return messageQueueClient.publish(messages: messages, to: topic)
    }

    public func publish(messages: [AmericaMessage]) -> EventLoopFuture<PublishResponse> {
        return messageQueueClient.publish(messages: messages, to: topic)
    }
}
