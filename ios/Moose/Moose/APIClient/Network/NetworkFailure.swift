import Foundation

enum NetworkFailure: Error {
    case offline
    case unauthorized
    case serverErrorMessage(String)
    case clientError(Int, JSON?)
    case serverError(Int)
    case underlyingHTTPErrors([Error])
    case emptyResult
}
