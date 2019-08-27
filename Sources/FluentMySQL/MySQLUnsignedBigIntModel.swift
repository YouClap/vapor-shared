import FluentMySQL
import Foundation

typealias UnsignedBigInt = UInt64

protocol MySQLUnsignedBigIntModel: _MySQLModel where Self.ID == UnsignedBigInt {
    var id: ID? { get set }
}

extension MySQLUnsignedBigIntModel {
    static var idKey: IDKey { return \.id }
}

extension UnsignedBigInt: Fluent.ID {}
