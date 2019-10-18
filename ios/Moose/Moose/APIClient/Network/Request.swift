import Foundation

typealias JSON = [String: Any]
typealias HTTPParameter = JSON
typealias HTTPHeader = [String: String]

enum HTTPMethod: String {
    case POST
    case GET
    case PATCH
    case HEAD
    case DELETE
    case PUT
}

protocol APIConfiguration {
    var baseURL: URL { get }
    var authenticationTokenHeader: HTTPHeader { get }
    var acceptHeader: HTTPHeader { get }
}

protocol Requestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeader? { get }
    var parameter: HTTPParameter? { get }
    var body: JSON? { get }
    var configuration: APIConfiguration { get }
    @discardableResult
    func request<M: Codable>(client: NetworkClientRequestable, _ completion: @escaping (Result<M>) -> Void) -> URLRequest
}

extension Requestable {
    @discardableResult
    func request<M: Codable>(client: NetworkClientRequestable, _ completion: @escaping (Result<M>) -> Void) -> URLRequest {
        var request = URLRequest(url: configuration.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        var headerFields = header ?? [:]
        headerFields.merge(configuration.authenticationTokenHeader, uniquingKeysWith: +)
        headerFields.merge(configuration.acceptHeader, uniquingKeysWith: +)
        request.allHTTPHeaderFields = headerFields
        if let parameter = parameter, let url = request.url {
            request.url = url.appendingQuery(parameter)
        }
        if let body = body {
            request.updateHTTPBody(parameter: body)
        }
        client.request(request) { result in
            completion(M.decode(result))
        }
        return request
    }
}
