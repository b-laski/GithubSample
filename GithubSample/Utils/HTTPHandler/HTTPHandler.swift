//
//  HTTPHandler.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import Alamofire
import Foundation

protocol HTTPHandlerProtocol {
    func make<T: Codable>(request: URLRequestConvertible, completion: @escaping (Result <T, Error>) -> Void)
    func cancel()
}

final class HTTPHandler: HTTPHandlerProtocol {
    
    var req: DataRequest?
    
    func make<T: Codable>(request: URLRequestConvertible, completion: @escaping (Result <T, Error>) -> Void) {
        
        req = AF.request(request)
        
        req?.responseDecodable(of: T.self) { result in
            
            if let error = result.error {
                completion(.failure(error))
            } else if let value = result.value {
                completion(.success(value))
            }
        }
    }
    
    func cancel() {
        if req != nil {
            req?.cancel()
        }
    }
    
}
