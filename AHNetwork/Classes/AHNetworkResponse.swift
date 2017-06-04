//
//  AHNetworkResponse.swift
//  Pods
//
//  Created by Alex Hmelevski on 2017-06-05.
//
//

import Foundation

public struct AHNetworkResponse {
    public let statusCode: Int
    public let data: Data
    public let response: URLResponse
    
    init?(data: Data?, response: URLResponse?) {
        guard let d = data,
            let r = response as? HTTPURLResponse else { return nil }
        self.data = d
        self.response = r
        statusCode = r.statusCode
    }
}
