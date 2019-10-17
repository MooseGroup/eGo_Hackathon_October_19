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
        return bookings(.GET, completion: completion)
    }

    @discardableResult
    func bookings(_ method: HTTPMethod, parameter: Request? = nil, request: Request? = nil,
                  completion: @escaping (Result<Response>) -> Void) -> URLRequest {
        return Endpoint("bookings", method: method, parameter: parameter?.json, body: request?.json).request(client: networkClient, completion)
    }
}
