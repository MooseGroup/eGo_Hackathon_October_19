import Foundation

struct BookingsEndpoint: HasNetworkClient {
    let networkClient: NetworkClientRequestable
}

extension BookingsEndpoint {

    @discardableResult
    func getBookings(completion: @escaping (Result<APIResponse<[Booking]>>) -> Void) -> URLRequest {
        return Endpoint("bookings", method: .GET).request(client: networkClient, completion)
    }
}
