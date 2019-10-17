import Foundation

struct Booking: Codable {
    enum Status: String, Codable {
        case unknown, new, cancelled
    }
    var id: String
    var event: String
    var city: String?
    var cityLat: Double?
    var cityLng: Double?
    var seatsTotal: Int?
    var seatsAvailable: Int?
    var displayName: String?
    var from: Date
    var until: Date
    var time: Date
    var status: Status
    var vehicle: Vehicle
}
