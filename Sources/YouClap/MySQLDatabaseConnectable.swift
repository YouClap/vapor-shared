import MySQL
import Service

public final class MySQLDatabaseConnectable: ContainerAlias {
    public static var aliasedContainer: KeyPath<MySQLDatabaseConnectable, Container> = \.container

    private let container: Container

    public init(container: Container) {
        self.container = container
    }

    // MARK: - DatabaseConnectable Protocol Methods

    public func connection<T>(_ closure: @escaping (MySQLConnection) throws -> Future<T>) -> Future<T> {
        return container.withPooledConnection(to: .mysql, closure: closure)
    }

    public func transaction<T>(_ closure: @escaping (MySQLConnection) throws -> Future<T>) -> Future<T> {
        return container.withPooledConnection(to: .mysql) { MySQLDatabase.transactionExecute(closure, on: $0) }
    }
}
