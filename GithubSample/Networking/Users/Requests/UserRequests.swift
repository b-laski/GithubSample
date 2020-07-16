//
//  UserRequests.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import Alamofire

struct SearchParams: Encodable {
    var q: String?
    var page: Int = 1
}

enum UserRequests: URLRequestConvertible {
    
    case searchUsers(parameters: SearchParams)
    case getMoreUsers(parameters: SearchParams)
    
    static let baseUrl: String = "https://api.github.com/"
    
    var method: HTTPMethod {
        switch self {
        case .searchUsers, .getMoreUsers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchUsers, .getMoreUsers:
            return "search/users";
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try UserRequests.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = method
        
        switch self {
        case .searchUsers(let params), .getMoreUsers(parameters: let params):
            urlRequest = try URLEncodedFormParameterEncoder.default.encode(params, into: urlRequest)
        }
        
        return urlRequest
    }
}
