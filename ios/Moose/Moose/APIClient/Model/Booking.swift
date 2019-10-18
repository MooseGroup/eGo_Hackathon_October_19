import Foundation

struct Booking: Codable {
    enum Status: String, Codable {
        case unknown, new, cancelled, active, finished
    }
    var id: String?
    var event: String?
    var city: String?
    var cityLat: Double?
    var cityLng: Double?
    var seatsTotal: Int = 4
    var seatsAvailable: Int?
    var displayName: String?
    var from: Date?
    var until: Date?
    var time: Date?
    var status: Status?
    var vehicle: Vehicle?

    var createNewRequest: CreateNewRequest {
        return CreateNewRequest(from: from ?? Date(),
                                until: until ?? Date(),
                                city: city ?? "",
                                cityLat: cityLat ?? 0.0,
                                cityLng: cityLng ?? 0.0,
                                displayName: displayName ?? "",
                                seatsAvailable: seatsAvailable ?? 0,
                                seatsTotal: seatsTotal)
    }

    var updateRequest: UpdateRequest {
        return UpdateRequest(seatsAvailable: seatsAvailable ?? 0)
    }
}

extension Booking {
    struct CreateNewRequest: Codable {
        let from: Date
        let until: Date
        let city: String
        let cityLat: Double
        let cityLng: Double
        let displayName: String
        let seatsAvailable: Int
        let seatsTotal: Int
    }

    struct UpdateRequest: Codable {
        let seatsAvailable: Int
    }
}
