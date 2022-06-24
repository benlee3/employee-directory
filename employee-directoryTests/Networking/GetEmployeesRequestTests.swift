//
//  GetEmployeesRequestTests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

class GetEmployeesRequestTests: XCTestCase {
    func testSuccessfulCall() throws {
        let session = URLSession(mockResponder: Mocks.MockDataURLResponder.self)
        let publisher = GetEmployeesRequest().execute(urlSession: session)
        let result = try awaitCompletion(of: publisher)
        
        XCTAssertEqual(result.first?.employees, Mocks.twoEmployees)
    }
    
    func testFailedCall() {
        let session = URLSession(mockResponder: Mocks.MalformedMockDataURLResponder.self)
        let publisher = GetEmployeesRequest().execute(urlSession: session)
        XCTAssertThrowsError(try awaitCompletion(of: publisher), "should throw decode error") { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.decodeError("The data couldn’t be read because it isn’t in the correct format."))
        }
    }
}
