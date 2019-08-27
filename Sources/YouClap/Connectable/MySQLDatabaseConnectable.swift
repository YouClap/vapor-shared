import FluentMySQL
import Vapor

final class MySQLDatabaseConnectable: ContainerAlias {
    static var aliasedContainer: KeyPath<MySQLDatabaseConnectable, Container> = \.container

    private let container: Container

    init(container: Container) {
        self.container = container
    }

    // MARK: - DatabaseConnectable Protocol Methods

    func connection<T>(_ closure: @escaping (MySQLConnection) throws -> Future<T>) -> Future<T> {
        return container.withPooledConnection(to: .mysql, closure: closure)
    }

    func transaction<T>(_ closure: @escaping (MySQLConnection) throws -> Future<T>) -> Future<T> {
        return container.withPooledConnection(to: .mysql) { MySQLDatabase.transactionExecute(closure, on: $0) }
    }
}
