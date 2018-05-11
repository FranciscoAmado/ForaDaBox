import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // Basic "Hello, world!" example
    router.get("/") { req in

        return req.redirect(to: "/index.html")
    }

    // Example of configuring a controller
    let eventController = EventController()
    router.get("api/events", use: eventController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
}
