import Foundation

struct BookingsEndpoint: HasNetworkClient {
    let networkClient: NetworkClientRequestable
}

extension BookingsEndpoint {

    @discardableResult
    func getBookings(completion: @escaping (Result<APIResponse<[Booking]>>) -> Void) -> URLRequest {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            completion(Result.failure(NSError(domain: "mooose", code: -1, userInfo: nil)))
        }

        return Endpoint("booking", method: .GET).request(client: networkClient, completion)
    }
}
