import Foundation

struct SignUpResponse: Decodable {
    let data: SignUpResponseData
}

struct SignUpResponseData: Decodable {
    let accessToken: String
    let refreshToken: String
}
