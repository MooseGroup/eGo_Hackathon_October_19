import Foundation

extension NetworkClient {
    struct Response {
        let data: Data
        let response: URLResponse
        let servedFromCache: Bool
        init(data: Data, response: URLResponse, servedFromCache: Bool = false) {
            self.data = data
            self.response = response
            self.servedFromCache = servedFromCache
        }
    }
}
