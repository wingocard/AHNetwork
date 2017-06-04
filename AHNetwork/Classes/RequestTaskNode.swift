//
//  RequestTaskNode.swift
//  Pods
//
//  Created by Alex Hmelevski on 2017-06-05.
//
//

import Foundation

final class RequestTaskNode: BasicTaskNode {
    var responseAdapter: INetworkResponseAdapter = AHNetworkResponseAdapter()
    
    override func send(request: NetworkTaskRequest, completion: completionHandler?) -> ICancellable {
        guard case .request = request.type else {
            return super.send(request: request, completion: completion)
        }
        
        let task = session.dataTask(with: request.urlRequest, completionHandler: { (data, response, error) in
            completion?(self.responseAdapter.response(from: data, with: response, and: error))
        })
        
        task.resume()
        
        return task
    }
}
