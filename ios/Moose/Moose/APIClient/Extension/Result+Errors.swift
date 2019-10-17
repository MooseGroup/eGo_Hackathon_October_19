import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)

    var value: T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}

extension Decodable {
    static func decode(_ result: Result<Response>) -> Result<Self> {
        guard let response = result.value else {
            return .failure(result.error ?? SerializationError.emptyResult)
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let model = try decoder.decode(self, from: response.data) as Self
            return .success(model)
        } catch let error {
            return .failure(error)
        }
    }
}

enum SerializationError: Error, LocalizedError {
    case emptyResult
    case missing(String)
    case invalid(String, Any)

    var errorDescription: String? {
        return String(describing: self)
    }
}
