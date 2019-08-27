import Vapor

final class HealthCheckController: RouterController {
    func boot(router: Router) throws {
        router.get("healthcheck", use: healthcheck)
    }

    private func healthcheck(_ request: Request) -> Future<HTTPStatus> {
        return request.future(.noContent)
    }
}
