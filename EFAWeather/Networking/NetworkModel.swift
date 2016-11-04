//
//  NetworkModel.swift
//  EFAB
//
//  Created by Brett Keck on 5/17/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

protocol NetworkModel: JSONDecodable {
    init(json: JSON) throws
    init()
    
    func method() -> Alamofire.HTTPMethod
    func path() -> String
    func toDictionary() -> [String: AnyObject]?
}
