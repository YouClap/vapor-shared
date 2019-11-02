import Foundation

struct AmericaMessage: Encodable {
    let action: Action
    let collection: Collection
    let documentID: String
    let data: Data

    init(action: Action, collection: Collection, documentID: String) {
        self.action = action
        self.collection = collection
        self.documentID = documentID
        self.data = .none
    }

    init(action: Action, collection: Collection, documentID: String, model: Encodable) {
        self.action = action
        self.collection = collection
        self.documentID = documentID
        self.data = .model(model)
    }
}

extension AmericaMessage {
    enum Action: String, Encodable {
        case create = "CREATE"
        case update = "UPDATE"
        case markDeleted = "MARK_DELETED"
        case delete = "DELETE"
    }

    enum Collection: String, Encodable {
        case blockedUser = "blocked-user"
        case challenge
        case following
        case group
        case post
        case user
    }

    enum Data {
        case model(Encodable)
        case none
    }
}

extension AmericaMessage.Data: Encodable {
    func encode(to encoder: Encoder) throws {
        switch self {
        case .model(let model): try model.encode(to: encoder)
        case .none: break
        }
    }
}
