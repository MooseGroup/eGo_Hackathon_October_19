import Foundation

struct BookingsEndpoint: HasNetworkClient {
    let networkClient: NetworkClientRequestable
}

extension BookingsEndpoint {

    @discardableResult
    func bookings(_ method: HTTPMethod,
                  completion: @escaping (Result<Booking>) -> Void) -> URLRequest {
        
        return Endpoint("bookings", method: method).request(client: networkClient, completion)
    }
}
