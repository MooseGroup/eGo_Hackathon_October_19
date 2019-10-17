import Foundation

struct Vehicle: Codable {
    enum Status: String, Codable {
        case unknown, charging, available
    }
    var id: String?
    var country: String?
    var environment: Environment?
    var licensePlate: String?
    var manufacturer: String?
    var model: String?
    var status: Status?
    var team: Team?
}
