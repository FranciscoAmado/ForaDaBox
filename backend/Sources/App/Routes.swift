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
    router.post("api/events", use: eventController.create)
    router.put("api/events", use: eventController.update)
//    router.delete("api/events", Event.parameter, use: eventController.delete)
}
