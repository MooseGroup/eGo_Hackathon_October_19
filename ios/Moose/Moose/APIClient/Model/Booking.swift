import Foundation

struct Booking: Codable {
    enum Status: String, Codable {
        case unknown, new
    }
    let event: String
    let id: String
    let from: Date
    let until: Date
    let time: Date
    let status: Status
    let vehicle: Vehicle
}
