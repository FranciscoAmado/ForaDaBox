import FluentSQLite
import Vapor

/// A single entry of a Calendar.
final class Event: SQLiteModel {

    /// The unique identifier for this `Event`.
    var id: Int?
    var title: String
    var date: String
    var time: String
//    var attendees: [String]

    /// Creates a new `Event`.
    init(id: Int? = nil, title: String, date: String, time: String) {
        self.id = id
        self.title = title
        self.date = date
        self.time = time
//        self.attendees = attendees
    }
}

/// Allows `Event` to be used as a dynamic migration.
extension Event: Migration { }

/// Allows `Event` to be encoded to and decoded from HTTP messages.
extension Event: Content { }

/// Allows `Event` to be used as a dynamic parameter in route definitions.
extension Event: Parameter { }
