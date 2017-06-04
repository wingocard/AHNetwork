//
//  AHMethod.swift
//  Pods
//
//  Created by Alex Hmelevski on 2017-06-05.
//
//

import Foundation

public enum AHMethod {
    case post
    case get
    
    var string: String {
        let str: String
        switch  self {
            case .post: str = "POST"
            case .get: str = "GET"
        }
        return str
    }
}
