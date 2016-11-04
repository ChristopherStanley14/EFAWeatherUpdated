
//
//  WebServices.swift
//  EFAB
//
//  Created by Brett Keck on 5/17/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class WebServices: NSObject {
    static let shared = WebServices()
    
    fileprivate var _baseURL = ""
    var baseURL : String {
        get {
            return _baseURL
        }
        set {
            _baseURL = newValue
        }
    }
    
    fileprivate var authToken: String? = nil
    
    func setAuthToken(_ token: String?, expiration: String?) {
        authToken = token
    }
    
    func userAuthTokenExists() -> Bool {
        if self.authToken != nil {
            return true
        }
        else {
            return false
        }
    }
    
    func clearUserAuthToken() {
        if self.userAuthTokenExists() {
            self.authToken = nil
        }
    }
    
    enum AuthRouter: URLRequestConvertible {

        static let baseURLString = WebServices.shared._baseURL
        static var OAuthToken: String?
        
        case restRequest(NetworkModel)
        
        func asURLRequest() throws -> URLRequest {
            let URL = try AuthRouter.baseURLString.asURL()
            var urlRequest: URLRequest
            
            switch self {
            case .restRequest(let model):
                urlRequest = URLRequest(url: URL.appendingPathComponent(model.path()))
                
                urlRequest.httpMethod = model.method().rawValue
                
                if let token = WebServices.shared.authToken {
                    urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                }
                
                if let params = model.toDictionary() {
                    if model.method() == .get {
                        return try! URLEncoding.default.encode(urlRequest, with: params)
                    } else {
                        return try! JSONEncoding.default.encode(urlRequest, with: params)
                    }
                }
                
                return urlRequest
            }
        }
    }
}
