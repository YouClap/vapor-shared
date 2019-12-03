import Foundation
import GoogleCloudPubSubKit
import NIO

public protocol AmericaStore: Service {
    func publish(messages: AmericaMessage...) -> EventLoopFuture<PublishResponse>
}

extension Store: AmericaStore {
    private var topic: ProjectTopic { ProjectTopic(project: messageQueueClient.project, name: "america") }

    public func publish(messages: AmericaMessage...) -> EventLoopFuture<PublishResponse> {
        return messageQueueClient.publish(messages: messages, to: topic)
    }
}


