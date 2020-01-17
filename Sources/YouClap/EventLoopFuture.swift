import NIO

public extension EventLoopFuture {
    func mapError(_ callback: @escaping (Error) -> Error) -> EventLoopFuture<T> {
        thenIfError(self.eventLoop.newFailedFuture)
    }

    func flatMap<U>(_ callback: @escaping (T) throws -> [EventLoopFuture<U>]) -> EventLoopFuture<[U]> {
        then {
            do {
                return EventLoopFuture<U>.whenAll(try callback($0), eventLoop: self.eventLoop)
            } catch {
                return self.eventLoop.newFailedFuture(error: error)
            }
        }
    }

    func flatMap<U>(_ callback: @escaping (T) throws -> [EventLoopFuture<U>]) -> EventLoopFuture<Void> {
        then {
            do {
                return EventLoopFuture<U>.andAll(try callback($0), eventLoop: self.eventLoop)
            } catch {
                return self.eventLoop.newFailedFuture(error: error)
            }
        }
    }
}
