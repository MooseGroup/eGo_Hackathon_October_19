
import Foundation

struct Booking: Codable {
    let event: String
    let id: String
    let status: String
    let time: Date
    let vehicle: Vehicle
}
