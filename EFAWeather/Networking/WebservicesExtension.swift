//
//  WebservicesExtension.swift
//  EFAB
//
//  Created by Brett Keck on 5/17/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

extension WebServices {
    func getObject<T: NetworkModel>(_ model: T, completion: @escaping (_ object: T?, _ error: String?) -> Void) {
        request(AuthRouter.restRequest(model)).responseJSON { (response) in
            WebServices.parseResponseObject(response: response, completion: completion)
        }
    }
    
    func postObject<T: NetworkModel>(_ model: T, completion: @escaping (_ object: T?, _ error: String?) -> Void) {
        request(AuthRouter.restRequest(model)).responseJSON { (response) in
            WebServices.parseResponseObject(response: response, completion: completion)
        }
    }
    
    func getObjects<T: NetworkModel>(_ model: T, completion: @escaping (_ objects: [T]?, _ error: String?) -> Void) {
        request(AuthRouter.restRequest(model)).responseJSON { (response) in
            WebServices.parseResponseObjects(response: response, completion: completion)
        }
    }
    
    
    // MARK: - Response parsing functions
    class func parseResponseObject<T: NetworkModel>(response: DataResponse<Any>, completion: (_ object: T?, _ error: String?) -> Void) {
        var object: T?
        
        guard case .success(_) = response.result, let data = response.data else {
            if let statusCode = response.response?.statusCode, statusCode >= 200, statusCode < 300 {
                completion(T(), nil)
            } else {
                completion(nil, parseError(response: response))
            }
            return
        }
        
        do {
            let json = try JSON(data: data)
            object = try T(json: json)
            
            completion(object, nil)
        } catch {
            completion(nil, Constants.JSON.processingError)
        }
    }
    
    class func parseResponseObjects<T: NetworkModel>(response: DataResponse<Any>, completion: (_ objects: [T]?, _ error: String?) -> Void) {
        var errorString: String?
        var objects: [T]?

        guard case .success(_) = response.result, let data = response.data else {
            completion(nil, parseError(response: response))
            return
        }
        
        do {
            let json = try JSON(data: data)
            let people = try json.getArray(at: "").map(T.init)
            objects = people
        } catch {
            errorString = Constants.JSON.processingError
        }
        
        completion(objects, errorString)
    }
    
    class func parseError(response: DataResponse<Any>) -> String? {
        guard case let .failure(error) = response.result else {
            return Constants.JSON.unknownError
        }
        
        var errorString: String?
        
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                errorString = "Invalid URL: \(url) - \(error.localizedDescription)"
            case .parameterEncodingFailed(let reason):
                errorString = "Parameter encoding failed: \(error.localizedDescription) Failure Reason: \(reason)"
            case .multipartEncodingFailed(let reason):
                errorString = "Multipart encoding failed: \(error.localizedDescription) Failure Reason: \(reason)"
            case .responseValidationFailed(let reason):
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    errorString = "Downloaded file could not be read"
                case .missingContentType(let acceptableContentTypes):
                    errorString = "Content Type Missing: \(acceptableContentTypes)"
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    errorString = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                case .unacceptableStatusCode(let code):
                    errorString = "Response status code was unacceptable: \(code)"
                }
            case .responseSerializationFailed(let reason):
                errorString = "Response serialization failed: \(error.localizedDescription) Failure Reason: \(reason)"
            }
        } else if let error = error as? URLError {
            errorString = "URLError occurred: \(error)"
        } else {
            errorString = "Unknown error: \(error)"
        }
        
        return errorString
    }
}
