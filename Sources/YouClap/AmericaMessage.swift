import Foundation

public struct AmericaMessage: Encodable {
    public let action: Action
    public let collection: Collection
    public let documentID: String
    public let data: Data

    public init(action: Action, collection: Collection, documentID: String) {
        self.action = action
        self.collection = collection
        self.documentID = documentID
        self.data = .none
    }

    public init(action: Action, collection: Collection, documentID: String, model: Encodable) {
        self.action = action
        self.collection = collection
        self.documentID = documentID
        self.data = .model(model)
    }
}

extension AmericaMessage {
    public enum Action: String, Encodable {
        case create = "CREATE"
        case update = "UPDATE"
        case markDeleted = "MARK_DELETED"
        case delete = "DELETE"
    }

    public enum Collection: String, Encodable {
        case blockedUser = "blocked-user"
        case challenge
        case following
        case group
        case post
        case user
        case userUsername = "user-username"
    }

    public enum Data {
        case model(Encodable)
        case none
    }
}

extension AmericaMessage.Data: Encodable {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .model(let model): try model.encode(to: encoder)
        case .none: break
        }
    }
}
