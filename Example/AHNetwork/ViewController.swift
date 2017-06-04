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
    
    var baseURL: String { return "www.google.com"}
    var path: String { return "" }
    var parameters: [String : String] {
        return [:]
    }
    var headers: [String : String] {
        return [:]
    }
    var body: Data? { return nil }
    
    var method: AHMethod { return .get }
    var scheme: AHScheme { return .https }
    var taskType: AHTaskType {return .request }
}

enum TestError: Error {
    case notFound
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AHNetworkProvider<MyTestService>().requestFuture(for: .google)
                                                 .filter(predicate: {(200..<300).contains($0.statusCode)}, error: TestError.notFound)
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

