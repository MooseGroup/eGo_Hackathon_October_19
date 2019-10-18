import Foundation

struct BookingsEndpoint: HasNetworkClient {
    let networkClient: NetworkClientRequestable
}

extension BookingsEndpoint {

    @discardableResult
    func getBookings(completion: @escaping (Result<APIResponse<[Booking]>>) -> Void) -> URLRequest {
        return Endpoint("bookings", method: .GET).request(client: networkClient, completion)
    }

    @discardableResult
    func updateBookings(booking: Booking, completion: @escaping (Result<APIResponse<Booking>>) -> Void) -> URLRequest {
        let id = booking.id ?? ""
        let body = booking.updateRequest
        return Endpoint("bookings/\(id)", method: .PATCH, body: body).request(client: networkClient, completion)
    }
}
