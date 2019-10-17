import Foundation

protocol HasNetworkClient {
    var networkClient: NetworkClientRequestable { get }
}

protocol NetworkClientRequestable {
    @discardableResult
    func request(_ request: URLRequest, completion: @escaping (Result<Response>) -> Void) -> URLSessionDataTask?
}

class NetworkClient: NSObject, URLSessionTaskDelegate, NetworkClientRequestable {

    static let urlCache: URLCache = {
        let megabyte = 1024 * 1024
        return URLCache(memoryCapacity: megabyte * 50, diskCapacity: megabyte * 500, diskPath: nil)
    }()

    // MARK: Properties

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = NetworkClient.urlCache
        configuration.httpShouldSetCookies = true
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        return session
    }()

    // MARK: network requests


    @discardableResult
    func request(_ request: URLRequest, completion: @escaping (Result<Response>) -> Void) -> URLSessionDataTask? {
        let task = session.startDataTask(request: request) { (data, response, httpError) in
            DispatchQueue.main.async {
                if let error = self.determineFailure(data, response, httpError) {
                    completion(.failure(error))
                } else if let data = data, let response = response {
                    completion(.success(Response(data: data, response: response)))
                } else {
                    completion(.failure(NetworkFailure.emptyResult))
                }
            }
        }
        return task
    }

    // MARK: Helper

    func determineFailure(_ data: Data?, _ response: URLResponse?, _ httpError: Error?) -> Error? {
        var error: Error?
        if let httpURLResponse = response as? HTTPURLResponse {
            switch httpURLResponse.statusCode {
            case 401: error = NetworkFailure.unauthorized
            case 400 ..< 500: error = NetworkFailure.clientError(httpURLResponse.statusCode, json(from: data))
            case 500...: error = NetworkFailure.serverError(httpURLResponse.statusCode)
            default: break
            }
        }

        switch httpError {
        case let .some(nserror as NSError) where nserror.code == NSURLErrorNotConnectedToInternet:
            error = nserror
        case let .some(nserror as NSError):
            let errors = [error, nserror].compactMap {$0}
            error = NetworkFailure.underlyingHTTPErrors(errors)
        case .none: break
        }
        return error
    }

    private func json(from data: Data?) -> JSON? {
        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON else {
            return nil
        }
        return json
    }

    // Should be removed later. we should not trust invalid certs
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(
            .useCredential,
            URLCredential(trust: challenge.protectionSpace.serverTrust!)
        )
    }
}
