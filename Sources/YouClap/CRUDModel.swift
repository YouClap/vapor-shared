import Fluent

public protocol CRUDModel: Model {
    var deleted: Bool { get set }
}
