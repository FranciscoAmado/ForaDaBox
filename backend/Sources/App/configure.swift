import FluentPostgreSQL
import Vapor
//import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())
//    try services.register(LeafProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
//    let sqlite = try MySQLDatabase

    /// Register the configured SQLite database to the database config.
//    var databases = DatabasesConfig()
//    databases.add(database: sqlite, as: .sqlite)
//    services.register(databases)

//    /// Register custom MySQL Config
//    let mysqlConfig = MySQLDatabaseConfig(hostname: "localhost", port: 3306, username: "vapor")
//    services.register(mysqlConfig)

//    var databases = DatabasesConfig()
//    let database = PostgreSQLDatabase(config: PostgreSQLDatabaseConfig.default())
//    databases.add(database: database, as: .psql)
//    services.register(databases)

    // Configure a database
    var databases = DatabasesConfig()
    let hostname = Environment.get("DATABASE_HOSTNAME") ?? "localhost"
    let username = Environment.get("DATABASE_USER") ?? "vapor"
    let databaseName = Environment.get("DATABASE_DB") ?? "vapor"
    let password = Environment.get("DATABASE_PASSWORD") ?? "password"
    let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: hostname,
        username: username,
        database: databaseName,
        password: password
    )
    let database = PostgreSQLDatabase(config: databaseConfig)

    databases.add(database: database, as: .psql)
    services.register(databases)
    
    var migrations = MigrationConfig()
    migrations.add(model: Event.self, database: .psql)
    migrations.add(migration: EventSeed.self, database: .psql)
    services.register(migrations)

//    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    /// CORS configuration
    let corsConfig = CORSMiddleware.Configuration(
        allowedOrigin: .originBased,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent],
        exposedHeaders: [
            HTTPHeaderName.authorization.description,
            HTTPHeaderName.contentLength.description,
            HTTPHeaderName.contentType.description,
            HTTPHeaderName.contentDisposition.description,
            HTTPHeaderName.cacheControl.description,
            HTTPHeaderName.expires.description
        ]
    )
    middlewares.use(CORSMiddleware(configuration: corsConfig))

    // Register middlewares
    services.register(middlewares)
}
