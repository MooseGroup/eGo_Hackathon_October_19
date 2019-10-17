import Foundation

class APIClient {

    let networkClient: NetworkClientRequestable

    lazy var bookings = BookingsEndpoint(networkClient: networkClient)
    lazy var vehicles = VehicleEndpoint(networkClient: networkClient)

    init(networkClient: NetworkClientRequestable = NetworkClient()) {
        self.networkClient = networkClient
    }
}
