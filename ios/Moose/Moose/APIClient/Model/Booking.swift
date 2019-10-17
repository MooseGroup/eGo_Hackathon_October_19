import Foundation

struct Booking: Codable {
    enum Status: String, Codable {
        case unknown, new, cancelled
    }
    let event: String
    let city: String?
    let cityLat: Double?
    let cityLng: Double?
    let seatsTotal: Int?
    let seatsAvailable: Int?
    let id: String
    let from: Date
    let until: Date
    let time: Date
    let status: Status
    let vehicle: Vehicle
}
