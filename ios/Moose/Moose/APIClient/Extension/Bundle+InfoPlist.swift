import Foundation

extension Bundle {

    struct API {
        private let dict: [String: Any]
        init(dict: [String: Any]) {
            self.dict = dict
        }

        var baseURL: URL {
            guard let base = dict["API_BASE_URL"] as? String, !base.isEmpty else {
                assertionFailure("BASE_URL must not be empty!")
                return URL(string: "")!
            }
            return URL(string: base)!
        }

        var apiKey: String {
            guard let token = dict["API_KEY"] as? String, !token.isEmpty else {
                assertionFailure("API_KEY must not be empty!")
                return ""
            }
            return token
        }
    }

    var api: API {
        let dict = infoDictionary?["API"] as? [String: Any] ?? [:]
        return API(dict: dict)
    }
}
