//
//  EmployeeDetailViewModelTests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

class EmployeeDetailViewModelTests: XCTestCase {
    var viewModel: EmployeeDetailViewModel!

    func testViewModel() {
        viewModel = EmployeeDetailViewModel(employee: Mocks.employeeAllFields)
        XCTAssertEqual(viewModel.name, "Ben Lee")
        XCTAssertEqual(viewModel.phoneNumber, "(123)-456-7890")
        XCTAssertEqual(viewModel.emailAddress, "ben@square.com")
        XCTAssertEqual(viewModel.biography, "I am a developer")
        XCTAssertEqual(viewModel.teamName, "iPhone")
        XCTAssertEqual(viewModel.employeeType, "Part Time")
    }
}
