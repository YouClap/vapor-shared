import Vapor

public final class HealthCheckController: RouterController {
    public func boot(router: Router) throws {
        router.get("healthcheck", use: healthcheck)
    }

    private func healthcheck(_ request: Request) -> Future<HTTPStatus> {
        return request.future(.noContent)
    }
}
