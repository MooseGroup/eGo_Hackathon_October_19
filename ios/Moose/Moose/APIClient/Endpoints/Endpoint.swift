import Foundation

struct DefaultAPIConfig: APIConfiguration {
    private var bundle: Bundle {
        return Bundle(for: NetworkClient.self)
    }
    var authenticationTokenHeader: HTTPHeader {
        return ["X-Api-Key": bundle.api.apiKey]
    }
    var acceptHeader: HTTPHeader {
        return ["accept": "application/json"]
    }
    var baseURL: URL {
        return bundle.api.baseURL
    }
    init() {}
}

struct Endpoint: Requestable {
    let path: String
    let method: HTTPMethod
    let parameter: HTTPParameter?
    let header: HTTPHeader?
    let body: JSON?
    let configuration: APIConfiguration
    init(_ path: String,
         method: HTTPMethod = .GET,
         parameter: HTTPParameter? = nil,
         body: JSON? = nil,
         header: HTTPHeader? = nil,
         configuration: APIConfiguration = DefaultAPIConfig()) {
        self.path = path
        self.method = method
        self.parameter = parameter
        self.body = body
        self.header = header
        self.configuration = configuration
    }
}
