import NIO

extension EventLoopFuture {
    func mapError(_ callback: @escaping (Error) -> Error) -> EventLoopFuture<T> {
        return thenIfError { error -> EventLoopFuture<T> in
            self.eventLoop.newFailedFuture(error: callback(error))
        }
    }
}
