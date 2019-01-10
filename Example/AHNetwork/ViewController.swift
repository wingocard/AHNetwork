//
//  ViewController.swift
//  AHNetwork
//
//  Created by AlexHmelevskiAG on 06/03/2017.
//  Copyright (c) 2017 AlexHmelevskiAG. All rights reserved.
//

import UIKit
import AHNetwork


enum MyTestService: IRequest {
    case google
    case s3
    var port: Int? {
        switch self {
        case .google:
            return 443
        case .s3:
            return nil
        }
    }
    var baseURL: String {
        switch self {
        case .google:
            return "www.google.com"
        case .s3:
            return "s3.amazonaws.com"
        }
    }
    var path: String {
        switch self {
        case .google:
            return ""
        case .s3:
            return "/esteban-test-public-bucket/package.zip"
        }
    }
    var taskType: AHTaskType {
        switch self {
        case .google:
            return .request
        case .s3:
            return .download
        }
    }
    var parameters: [String : String] {
        return [:]
    }
    var headers: [String : String] {
        return [:]
    }
    var body: Data? { return nil }
    
    var method: AHMethod { return .get }
    var scheme: AHScheme { return .https }
}

enum TestError: Error {
    case notFound
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AHNetworkProvider().requestFuture(for: MyTestService.google)
                                                 .filter(predicate: { (200..<300).contains($0.statusCode) }, error: TestError.notFound)
                                                 .map(transform: { String.init(data: $0.data, encoding: .ascii)! })
                                                 .onSuccess(callback: {print($0)})
                                                 .onFailure(callback: {print($0)})
                                                 .execute()

        AHNetworkProvider().requestFuture(for: MyTestService.s3)
            .filter(predicate: { (200..<300).contains($0.statusCode) }, error: TestError.notFound)
            .map(transform: { String.init(data: $0.data, encoding: .ascii)! })
            .onSuccess(callback: {print($0)})
            .onFailure(callback: {print($0)})
            .execute()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

