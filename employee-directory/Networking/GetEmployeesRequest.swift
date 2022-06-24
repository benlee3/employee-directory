//
//  GetEmployeesRequest.swift
//  employee-directory
//
//  Created by Ben Lee on 6/20/22.
//

import Combine
import Foundation

protocol GetEmployeesRequestProvider {
    func request() -> GetEmployeesRequestProvider
    func execute(urlSession: URLSession) -> AnyPublisher<GetEmployeesResponse, NetworkError>
}

struct GetEmployeesRequest: APIRequest, Codable {
    typealias ResponseType = GetEmployeesResponse
    static let url = URL(string: successfulResponseURL)! // force unwrapping because we have a hardcoded URL. Would typically add percent encoding and some input sanitzation for dynamically built URLs
    static let request = URLRequest(url: url)
    
    func execute(urlSession: URLSession = .shared) -> AnyPublisher<GetEmployeesResponse, NetworkError> {
        return urlSession.dataTaskPublisher(for: GetEmployeesRequest.request).eraseToAnyPublisher()
            .tryMap { rawResponse -> Data in
                guard let response = rawResponse.response as? HTTPURLResponse else {
                    throw NetworkError.apiError("malformed response")
                }
                guard Array(200...299).contains(response.statusCode) else {
                    throw NetworkError.apiError("received HTTP Status Code: \(response.statusCode)")
                }
                return rawResponse.data
            }
            .decode(type: GetEmployeesResponse.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.decodeError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

extension GetEmployeesRequest {
    static let successfulResponseURL = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    static let malformedResponseURL = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    static let emptyResponseURL = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}

struct GetEmployeesResponse: APIResponse, Codable {
    let employees: [Employee]
}
