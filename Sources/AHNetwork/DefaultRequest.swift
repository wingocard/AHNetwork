//
//  DefaultRequest.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-05.
//

import Foundation

public struct DefaultRequest: IRequest {
    public let baseURL: String

    public let path: String

    public let parameters: [String: String]

    public let headers: [String: String]

    public let body: Data?

    public let method: AHMethod

    public let scheme: AHScheme

    public let taskType: AHTaskType

    public let port: Int?

    public init(baseURL: String,
                path: String = "",
                parameters: [String: String] = [:],
                headers: [String: String],
                body: Data? = nil,
                method: AHMethod = .get,
                scheme: AHScheme = .https,
                taskType: AHTaskType = .request,
                port: Int? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.headers = headers
        self.parameters = parameters
        self.body = body
        self.method = method
        self.scheme = scheme
        self.taskType = taskType
        self.port = port
    }

    public func new(scheme: AHScheme) -> Self {
        return Self(baseURL: baseURL,
                    path: path,
                    parameters: parameters,
                    headers: headers,
                    body: body,
                    method: method,
                    scheme: scheme,
                    taskType: taskType,
                    port: port)
    }

    public func appended(path: String) -> Self {
        return Self(baseURL: baseURL,
                    path: "\(self.path)\(path)",
                    parameters: parameters,
                    headers: headers,
                    body: body,
                    method: method,
                    scheme: scheme,
                    taskType: taskType,
                    port: port)
    }

    public func new(baseURL: String) -> Self {
        return Self(baseURL: baseURL,
                    path: path,
                    parameters: parameters,
                    headers: headers,
                    body: body,
                    method: method,
                    scheme: scheme,
                    taskType: taskType,
                    port: port)
    }

    public func new(body: Data) -> Self {
        return Self(baseURL: baseURL,
                    path: path,
                    parameters: parameters,
                    headers: headers,
                    body: body,
                    method: method,
                    scheme: scheme,
                    taskType: taskType,
                    port: port)
    }

    public func new(method: AHMethod) -> Self {
          return Self(baseURL: baseURL,
                      path: path,
                      parameters: parameters,
                      headers: headers,
                      body: body,
                      method: method,
                      scheme: scheme,
                      taskType: taskType,
                      port: port)
    }

    public func appending(headers: [String: String]) -> Self {
        var newHeaders = self.headers
        headers.forEach { (pair) in
            newHeaders[pair.key] = pair.value
        }

        return Self(baseURL: baseURL,
                    path: path,
                    parameters: parameters,
                    headers: newHeaders,
                    body: body,
                    method: method,
                    scheme: scheme,
                    taskType: taskType,
                    port: port)
    }

    public func new(parameters: [String: String]) -> Self {
        return Self(baseURL: baseURL,
                    path: path,
                    parameters: parameters,
                    headers: headers,
                    body: body,
                    method: method,
                    scheme: scheme,
                    taskType: taskType,
                    port: port)
    }
}
