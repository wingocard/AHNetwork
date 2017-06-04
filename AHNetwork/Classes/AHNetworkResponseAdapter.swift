//
//  AHNetworkResponseAdapter.swift
//  Pods
//
//  Created by Alex Hmelevski on 2017-06-05.
//
//

import Foundation
import ALEither

protocol INetworkResponseAdapter {
    func response(from data: Data?,with response: URLResponse?, and error: Error?) -> ALEither<AHNetworkResponse,Error>
}

struct AHNetworkResponseAdapter: INetworkResponseAdapter {
    func response(from data: Data?, with response: URLResponse?, and error: Error?) -> ALEither<AHNetworkResponse, Error> {
            let resp = AHNetworkResponse.init(data: data, response: response)
            guard let result = ALEither(value: resp, error: error) else {
                fatalError("Cannont create ALEither")
            }
        return result
    }
}
