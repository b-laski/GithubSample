//
//  HTTPHandlerLogger.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 14/07/2020.
//

import Alamofire
import Foundation

final class HTTPHandlerLogger {
    public static let shared = HTTPHandlerLogger()
    
    public var filterPredicate: NSPredicate?
    
    private let queue = DispatchQueue(label: "\(HTTPHandlerLogger.self) Queue")
    
    deinit {
        stopLogging()
    }
    
    func startLogging() {
        stopLogging()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(HTTPHandlerLogger.requestDidStart(notification:)),
            name: Request.didResumeNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(HTTPHandlerLogger.requestDidFinish(notification:)),
            name: Request.didFinishNotification,
            object: nil
        )
    }
    
    func stopLogging() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func requestDidStart(notification: Notification) {
        queue.async {
            guard let dataRequest = notification.request as? DataRequest,
                let task = dataRequest.task,
                let request = task.originalRequest,
                let httpMethod = request.httpMethod,
                let requestURL = request.url
                else {
                    return
            }
            
            if let filterPredicate = self.filterPredicate, filterPredicate.evaluate(with: request) {
                return
            }
            
            self.logDivider()
            print("\(httpMethod) '\(requestURL.absoluteString)':")
            self.logHeaders(headers: request.allHTTPHeaderFields ?? [:])
            
        }
    }
    
    @objc private func requestDidFinish(notification: Notification) {
        queue.async {
            guard let dataRequest = notification.request as? DataRequest,
                let task = dataRequest.task,
                let metrics = dataRequest.metrics,
                let request = task.originalRequest,
                let httpMethod = request.httpMethod,
                let requestURL = request.url
                else {
                    return
            }
            
            if let filterPredicate = self.filterPredicate, filterPredicate.evaluate(with: request) {
                return
            }
            
            let elapsedTime = metrics.taskInterval.duration
            
            self.logDivider()
            if let error = task.error {
                print("[Error] \(httpMethod) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
                print(error)
            } else {
                guard let response = task.response as? HTTPURLResponse else {
                    return
                }
                print("\(String(response.statusCode)) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
                self.logHeaders(headers: response.allHeaderFields)
                guard let data = dataRequest.data else { return }
                
                print("----------------------- Body -----------------------")
                
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    
                    if let prettyString = String(data: prettyData, encoding: .utf8) {
                        print(prettyString)
                    }
                } catch {
                    if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        print(string)
                    }
                }
            }
        }
    }
}

private extension HTTPHandlerLogger {
    func logDivider() {
        print("---------------------")
    }
    
    func logHeaders(headers: [AnyHashable : Any]) {
        print("----------------------- Headers ----------------------- \n[")
        for (key, value) in headers {
            print("  \(key): \(value)")
        }
        print("]")
    }
}
