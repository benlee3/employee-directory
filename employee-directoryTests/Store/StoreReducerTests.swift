//
//  StoreReducerTests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

class StoreReducerTests: XCTestCase {
    var state: AppState = .initial

    func testReducer() {
        var effect = appReducer(state: &state, action: .loadApp)
        XCTAssertEqual(effect, .showList)
        effect = appReducer(state: &state, action: .setEmployees([Mocks.employeeAllFields]))
        XCTAssertEqual(effect, nil)
        effect = appReducer(state: &state, action: .employeeSelected(0))
        XCTAssertEqual(effect, .showEmployee(0))
    }
}
