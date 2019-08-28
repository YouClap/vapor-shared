import MySQL

public extension MySQLDatabaseConfig {
    static func loadFromEnvironment() -> MySQLDatabaseConfig? {
        guard
            let hostname = Environment.get("DB_HOSTNAME"),
            let portAsString = Environment.get("DB_PORT"),
            let port = Int(portAsString),
            let username = Environment.get("DB_USERNAME"),
            let password = Environment.get("DB_PASSWORD"),
            let database = Environment.get("DB_DATABASE")
            else {
                return nil
        }

        return MySQLDatabaseConfig(hostname: hostname,
                                   port: port,
                                   username: username,
                                   password: password,
                                   database: database,
                                   characterSet: MySQLCharacterSet.utf8mb4_unicode_ci)
    }
}
