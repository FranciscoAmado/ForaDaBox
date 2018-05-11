import Vapor

/// Controls basic CRUD operations on `Event`s.
final class EventController {
    /// Returns a list of all `Event`s.
    func index(_ req: Request) throws -> Future<[Event]> {
        let date = Date.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        let events: [Event] = [
            Event(title: "Mobilidade", date: "2018/05/10", time: "18h00"),
            Event(title: "Wod", date: dateFormatter.string(from: date), time: "18h45"),
            Event(title: "Wod", date: "2018/05/10", time: "20h00")
        ]

        return Future.map(on: req) { events }
    }

    /// Saves a decoded `Event` to the database.
    func create(_ req: Request) throws -> Future<Event> {
        return try req.content.decode(Event.self).flatMap { event in
            return event.save(on: req)
        }
    }

    /// Deletes a parameterized `Event`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Event.self).flatMap { event in
            return event.delete(on: req)
        }.transform(to: .ok)
    }
}
