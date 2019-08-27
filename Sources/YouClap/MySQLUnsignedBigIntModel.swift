import FluentMySQL
import Foundation

public typealias UnsignedBigInt = UInt64

public protocol MySQLUnsignedBigIntModel: _MySQLModel where Self.ID == UnsignedBigInt {
    var id: ID? { get set }
}

public extension MySQLUnsignedBigIntModel {
    static var idKey: IDKey { return \.id }
}

extension UnsignedBigInt: Fluent.ID {}
