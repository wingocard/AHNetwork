//
//  DownloadTaskNode.swift
//  AHFuture
//
//  Created by Esteban Garro on 2019-01-10.
//

import Foundation

final class DownloadTaskNode: BasicTaskNode {
    var downloadAdapter: INetworkDownloadAdapter = AHNetworkResponseAdapter()
    
    override func send(request: NetworkTaskRequest, completion: completionHandler?) -> ICancellable {
        guard case .download = request.type else {
            return super.send(request: request, completion: completion)
        }
        
        let task = session.downloadTask(with: request.urlRequest, completionHandler:{ (localURL, response, error) in
            completion?(self.downloadAdapter.response(from: localURL, with: response, and: error))
        })
        
        task.resume()
        
        return task
    }
}
