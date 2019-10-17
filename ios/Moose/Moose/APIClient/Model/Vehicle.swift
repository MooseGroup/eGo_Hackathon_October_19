import Foundation

struct Vehicle: Codable {
    enum Status: String, Codable {
        case charging
    }
    let id: String
    let country: String
    let environment: Environment
    let licensePlate: String
    let manufacturer: String
    let model: String
    let status: Status
    let team: Team
}
