import Foundation

public struct Airport: Codable {
    public let stationCode: String
    public let stationName: String
    public let stationType: StationType
    public let intercontinentalStation: Bool
    public let airlineCodes: [String]
    public let location: Location
}

public protocol HasAiportPayload {
    var payload: [Airport] { get }
}
