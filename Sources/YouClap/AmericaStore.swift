import Foundation
import GoogleCloudPubSubKit

public protocol AmericaStore: Service {
    func create(documents: AmericaDocumentInfo...) -> EventLoopFuture<PublishResponse>
    func update(documents: AmericaDocumentInfo...) -> EventLoopFuture<PublishResponse>
    func markDeleted(collection: AmericaMessage.Collection, documentID: String) -> EventLoopFuture<PublishResponse>
    func delete(collection: AmericaMessage.Collection, documentID: String) -> EventLoopFuture<PublishResponse>
}

extension Store: AmericaStore {
    private var topic: ProjectTopic { ProjectTopic(project: messageQueueClient.project, name: "america") }

    public func create(documents: AmericaDocumentInfo...) -> EventLoopFuture<PublishResponse> {
        let americaMessages = documents.map {
            AmericaMessage(action: .create, collection: $0.collection, documentID: $0.documentID, model: $0.model)
        }

        return messageQueueClient.publish(messages: americaMessages, to: topic)
    }

    public func update(documents: AmericaDocumentInfo...) -> EventLoopFuture<PublishResponse> {
        let americaMessages = documents.map {
            AmericaMessage(action: .update, collection: $0.collection, documentID: $0.documentID, model: $0.model)
        }

        return messageQueueClient.publish(messages: americaMessages, to: topic)
    }

    public func markDeleted(collection: AmericaMessage.Collection, documentID: String) -> EventLoopFuture<PublishResponse> {
        let americaMessage = AmericaMessage(action: .markDeleted, collection: collection, documentID: documentID)

        return messageQueueClient.publish(messages: americaMessage, to: topic)
    }

    public func delete(collection: AmericaMessage.Collection, documentID: String) -> EventLoopFuture<PublishResponse> {
        let americaMessage = AmericaMessage(action: .delete, collection: collection, documentID: documentID)

        return messageQueueClient.publish(messages: americaMessage, to: topic)
    }
}

