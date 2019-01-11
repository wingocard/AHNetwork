//
//  BasicTaskNode.swift
//  Pods
//
//  Created by Alex Hmelevski on 2017-06-05.
//
//

import Foundation

protocol INetworkTaskNode {
    init(session: URLSession)
    func send(request: NetworkTaskRequest, completion: completionHandler?, progress: progressTracker?) -> ICancellable
}

extension URLSessionTask: ICancellable {}

public protocol ICancellable {
    func cancel()
}

class BasicTaskNode: INetworkTaskNode {
    let session: URLSession
    private var nextLink: BasicTaskNode?
    
    required init(session: URLSession) {
        self.session = session
    }
    
    func send(request: NetworkTaskRequest, completion: completionHandler?, progress: progressTracker?) -> ICancellable {
        guard let cancellable = nextLink?.send(request: request, completion: completion, progress: progress) else {
            fatalError("Cancellable hasn't been returned")
        }
        return cancellable
    }
    
    static func createChain(from types: [BasicTaskNode.Type], using session: URLSession) -> INetworkTaskNode {
        let result = types.reversed().reduce(nil) { (result, type) -> BasicTaskNode? in
            var link = result
            let existingLink = link
            link = type.init(session: session)
            link?.nextLink = existingLink
            return link
        }
        guard let l = result else {
            fatalError("Couldn't create chain from array")
        }
        return l
    }
    
}
