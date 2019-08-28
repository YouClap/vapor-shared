import Core

public protocol CRUDStore {
    associatedtype M: CRUDModel
    associatedtype DatabaseConnection: MySQLDatabaseConnectable

    var databaseConnectable: DatabaseConnection { get }

    func create(model: M) -> Future<M>
    func read(by id: M.ID) -> Future<M>
    func update(model: M) -> Future<M>
    func delete(by id: M.ID) -> Future<M>
}

extension CRUDStore {
    public func create(model: M) -> Future<M> {
        return databaseConnectable.connection { model.save(on: $0) }
    }

    public func read(by id: M.ID) -> Future<M> {
        return databaseConnectable.connection {
            M.find(id, on: $0)
                .map {
                    guard let model = $0 else { throw CRUDStoreError.notFound }

                    return model
                }
        }
    }

    public func update(model: M) -> Future<M> {
        return databaseConnectable.connection { model.update(on: $0) }
    }

    public func delete(by id: M.ID) -> Future<M> {
        return databaseConnectable.connection {
            M.find(id, on: $0)
                .flatMap {
                    guard var model = $0 else { throw CRUDStoreError.notFound }

                    model.deleted = true

                    return self.update(model: model)
                }
        }
    }
}

public enum CRUDStoreError: Swift.Error {
    case notFound
}
