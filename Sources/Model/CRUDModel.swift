import Fluent

protocol CRUDModel: Model {
    var deleted: Bool { get set }
}
