//
//  UIStackView+setDirectionalLayoutMargins-Tests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

class UIStackView_setDirectionalLayoutMargins_Tests: XCTestCase {

    func testSetDirectionLayoutMargins() {
        let stack = UIStackView()
        stack.setDirectionalLayoutMargins(top: 0, leading: 0, bottom: 0, trailing: 0)
        XCTAssertTrue(stack.isLayoutMarginsRelativeArrangement)
        XCTAssertEqual(stack.directionalLayoutMargins, NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }

}
