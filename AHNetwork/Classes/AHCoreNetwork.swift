//
//  AHCoreNetwork.swift
//  AHFuture
//
//  Created by Alex Hmelevski on 2020-02-15.
//

import Foundation
import EitherResult
import Combine

public typealias AHCallback<T> = (ALResult<T>) -> Void

protocol AHCoreNetwork {
    func send(request: IRequest, completion: @escaping AHCallback<Data>)
    
    @available(iOS 13.0, *)
    func send(request: IRequest) -> AnyPublisher<AHNetworkResponse, URLError>
}

final class AHCoreNetworkImp: AHCoreNetwork {
 
    
    private let provider: INetworkProvider

    init(networkProvider: INetworkProvider) {
        provider = networkProvider
    }

    @available(iOS 13.0, *)
    func send(request: IRequest) -> AnyPublisher<AHNetworkResponse, URLError> {
        return provider.send(request)
        
     }
    /// Sends IRequest
    ///
    /// Performs status check
    /// - Parameters:
    ///   - request: request that conforms to IRequest
    ///   - completion: ALResult<Data>
    func send(request: IRequest, completion: @escaping AHCallback<Data>) {
        provider.send(request,
                      completion: { [weak self] in self?.processResult($0, completion: completion) },
                      progress: nil)
    }

    private func processResult(_ result: ALResult<AHNetworkResponse>,
                               completion: @escaping AHCallback<Data>) {
        result.onError({ completion(.wrong($0)) })
              .do(work: { self.proccess(response: $0, with: completion) })
    }

    private func proccess(response: AHNetworkResponse,
                          with completion: @escaping (ALResult<Data>) -> Void) {

        convertToError(networkResponse: response).do(work: { completion(.wrong($0)) })
                                                 .doIfNone { completion(.right(response.data)) }
    }
    
    

    private func convertToError(networkResponse: AHNetworkResponse) -> CoreNetworkError? {
        guard networkResponse.statusCode != 200  else { return nil }
        return .responseError(networkResponse)
    }
 
}

enum CoreNetworkError: LocalizedError {
    case timeout
    case responseError(AHNetworkResponse)

    var errorDescription: String? {
        var msg: String

        switch self {
        case .timeout:
            msg = "Response timeout"
        case let .responseError(networkResponse):
            msg = "Network status response: \(String(networkResponse.statusCode))"
        }

        return msg
    }
}
