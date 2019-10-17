import Foundation

public struct Header: Codable {
    public let httpStatusCode: Int
    public let version: String
    public let build: String
    public let requestId: String
}
