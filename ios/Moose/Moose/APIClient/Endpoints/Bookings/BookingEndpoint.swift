import Foundation

struct BookingsEndpoint: HasNetworkClient {
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
        return Endpoint("bookings", method: .GET).request(client: networkClient, completion)
    }
}
