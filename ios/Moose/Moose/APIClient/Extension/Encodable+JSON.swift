import Foundation

extension Encodable {
    var json: JSON {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(self),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON else {
                assertionFailure(String(describing: self) + " must be encodable to JSON")
                return JSON()
        }
        return json
    }
}
