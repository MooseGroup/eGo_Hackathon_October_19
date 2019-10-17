import Foundation

struct VehiclesEndpoint: HasNetworkClient {
    let networkClient: NetworkClientRequestable
}

extension VehiclesEndpoint {

    /// Returns a list of all vehicles.
    @discardableResult
    func getVehicles(completion: @escaping (Result<APIResponse<[Vehicle]>>) -> Void) -> URLRequest {
        return Endpoint("vehicles", method: .GET).request(client: networkClient, completion)
    }

    /// Creates a new booking for a vehicle.
    @discardableResult
    func createNewBooking(_ booking: Booking, completion: @escaping (Result<APIResponse<[Booking]>>) -> Void) -> URLRequest {
        let body = booking.createNewRequest
        return Endpoint("vehicles/\(booking.vehicle?.id ?? "")/bookings", method: .POST, body: body)
                .request(client: networkClient, completion)
    }
}
