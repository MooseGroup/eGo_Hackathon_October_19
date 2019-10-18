import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = URL(string: value)!
    }
}

extension URL {
    func appendingQuery(_ query: [String: Any]) -> URL {
        let url = self
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            //assertionFailure("Could not create urlComponents")
            return url
        }

        var queryItems = [URLQueryItem]()
        queryItems.append(contentsOf: urlComponents.queryItems ?? [])
        for key in query.keys.sorted() {
            if let value = query[key] {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
        }
        urlComponents.queryItems = queryItems
        guard let newURL = urlComponents.url else {
            return url
        }
        return newURL
    }
}

extension URLRequest {
    mutating func updateHTTPBody(parameter: [String: Any]) {
        guard let jsonData: Data = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {
            //assertionFailure("Could not serialize JSON")
            return
        }
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        setValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
        httpBody = jsonData
    }
}

extension URLSession {
    func startDataTask(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
