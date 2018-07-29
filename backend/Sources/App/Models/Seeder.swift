//
//  Seeder.swift
//  App
//
//  Created by Francisco Amado on 14/05/2018.
//

import Foundation

enum Type: String {
    case wod = "WOD"
    case superwod = "SUPERWOD"
    case mobility = "MBLTY"
}

class Seeder {

    static var events: [Event] {

        let numberOfEvents = 200

        let dateFormatter: DateFormatter = {

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            formatter.timeZone = TimeZone(identifier:"GMT")
            return formatter
        }()

        let timeIntervals: [(type: Type, start: String, end: String)] = [
            (type: .superwod, start: "11:00", end: "12:30"),
            (type: .wod, start: "12:30", end: "13:30"),
            // (type: .mobility, start: "18:00", end: "18:30"),
            (type: .wod, start: "18:30", end: "19:15"),
            (type: .wod, start: "19:30", end: "20:15")
        ]

        //dateFormatter.date(from: "2018/05/12 \(timeIntervals[0].start)")!,
        let initialWods: [(type: Type, date: Date, time: String)] = timeIntervals.compactMap {
            (type: $0.type, date: dateFormatter.date(from: "2018/07/20 \($0.start)")!, time: $0.start)
        }

        let calendar = Calendar.autoupdatingCurrent
        let composedWods: [(type: Type, date: Date, time: String)] = [Int](0...numberOfEvents).flatMap {
            index -> [(type: Type, date: Date, time: String)] in

            return initialWods.compactMap { wod -> (type: Type, date: Date, time: String)? in

                let mutatedDate = calendar.date(byAdding: .day, value: index, to: wod.date)!
                let weekday = calendar.component(.weekday, from: mutatedDate)
                let hour = calendar.component(.hour, from: mutatedDate)

                // Exclude Sundays
                if weekday == 1 { return nil }

                // Superwod only at Saturdays
                if weekday == 7 && wod.type == .superwod { return (type: wod.type, date: mutatedDate, time: wod.time) }
                else if weekday == 7 || wod.type == .superwod { return nil }

                // 7h15 excluded on Tue, Thu, Fri, Sat
                if hour == 8 && [3, 5, 6, 7].contains(weekday) { return nil }

                return (type: wod.type, date: mutatedDate, time: wod.time)
            }
        }

        let outputFormatter: DateFormatter = {

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            formatter.timeZone = TimeZone(identifier:"GMT")
            return formatter
        }()

        return composedWods.map { (type, date, time) -> Event in
            return Event.init(title: type.rawValue, date: outputFormatter.string(from: date), time: time, attendees: [])
        }
    }
}
