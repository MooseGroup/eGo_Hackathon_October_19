import Foundation

struct Booking: Codable {
    enum Status: String, Codable {
        case unknown, new, cancelled
    }
    var event: String?
    var city: String?
    var cityLat: Double?
    var cityLng: Double?
    var seatsTotal: Int?
    var seatsAvailable: Int?
    var id: String?
    var from: Date?
    var until: Date?
    var time: Date?
    var status: Status?
    var vehicle: Vehicle?
}
