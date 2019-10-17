import Foundation

struct BookingsEndpoint: HasNetworkClient {
    enum Path: String {
        case bookings
    }
    struct Parameter: Codable {}
    struct Request: Codable {}
    struct Response: Codable {
        let success: Bool
        let data: [Booking]
    }

    let networkClient: NetworkClientRequestable
}

extension BookingsEndpoint {

    @discardableResult
    func getBookings(completion: @escaping (Result<Response>) -> Void) -> URLRequest {
        return Endpoint(Path.bookings.value, method: .GET).request(client: networkClient, completion)
    }
}