import Foundation

struct Booking: Codable {
    enum Status: String, Codable {
        case unknown, new
    }
    var event: String
    var id: String
    var from: Date
    var until: Date
    var time: Date
    var status: Status
    var vehicle: Vehicle
}
