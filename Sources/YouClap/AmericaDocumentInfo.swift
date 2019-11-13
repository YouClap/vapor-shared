import Foundation

public struct AmericaDocumentInfo {
    public let model: Encodable
    public let collection: AmericaMessage.Collection
    public let documentID: String

    public init<Model: Encodable>(model: Model, collection: AmericaMessage.Collection, documentID: String) {
        self.model = model
        self.collection = collection
        self.documentID = documentID
    }
}
