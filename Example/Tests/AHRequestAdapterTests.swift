//
//  AHRequestAdapterTests.swift
//  AHNetwork
//
//  Created by Alex Hmelevski on 2017-06-05.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import AHNetwork

struct MockRequest: IRequest {
    var baseURL: String { return  "www.myApi.com" }
    var path: String { return "/console"}
    var parameters: [String : String] {
        return ["role": "admin","access" : "full"]
    }
    
    var headers: [String : String] {
        return ["username": "admin", "password" : "12345"]
    }
    
    var body: Data? { return "Test".data(using: .utf8)! }
    
    var method: AHMethod { return .get }
    var scheme: AHScheme { return .https }
    var taskType: AHTaskType { return .request }
    var port: Int? {return 980}
}

class AHRequestAdapterTests: XCTestCase {
    
    func test_adapter_uses_base_url() {
       let urlRequest =  AHRequestAdapter().urlRequest(for: MockRequest())
       XCTAssertEqual(urlRequest.url?.host, MockRequest().baseURL)
    }
    
    func test_adapter_uses_path() {
        let urlRequest =  AHRequestAdapter().urlRequest(for: MockRequest())
        XCTAssertEqual(urlRequest.url?.path, MockRequest().path)
    }
    
    func test_adapter_uses_scheme() {
        let urlRequest =  AHRequestAdapter().urlRequest(for: MockRequest())
        XCTAssertEqual(urlRequest.url?.scheme, MockRequest().scheme.string)
    }
    
    func test_adapter_uses_headers() {
        let urlRequest =  AHRequestAdapter().urlRequest(for: MockRequest())
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!, MockRequest().headers)
    }
    
    func test_adapter_uses_method() {
        let urlRequest =  AHRequestAdapter().urlRequest(for: MockRequest())
        XCTAssertEqual(urlRequest.httpMethod, MockRequest().method.string)
    }
    
    func test_adapter_uses_body() {
        let urlRequest =  AHRequestAdapter().urlRequest(for: MockRequest())
        XCTAssertEqual(urlRequest.httpBody, MockRequest().body)
    }
}
