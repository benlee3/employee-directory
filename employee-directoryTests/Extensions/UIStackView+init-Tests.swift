//
//  UIStackView+init-Tests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

class UIStackView_init_Tests: XCTestCase {
    func testAllValuesProvided() {
        let stack = UIStackView(alignment: .center,
                                axis: .vertical,
                                isBaselineRelativeArrangement: true,
                                distribution: .equalCentering,
                                margins: NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10),
                                spacing: 10,
                                backgroundColor: .black)
        XCTAssertEqual(stack.alignment, .center)
        XCTAssertEqual(stack.axis, .vertical)
        XCTAssertTrue(stack.isBaselineRelativeArrangement)
        XCTAssertEqual(stack.distribution, .equalCentering)
        XCTAssertEqual(stack.directionalLayoutMargins.top, 10)
        XCTAssertEqual(stack.directionalLayoutMargins.leading, 10)
        XCTAssertEqual(stack.directionalLayoutMargins.bottom, 10)
        XCTAssertEqual(stack.directionalLayoutMargins.trailing, 10)
        XCTAssertEqual(stack.spacing, 10)
        XCTAssertEqual(stack.backgroundColor, .black)
    }
    
    func testDefaultValuesUsed() {
        let stack = UIStackView(alignment: .trailing)
        XCTAssertEqual(stack.alignment, .trailing)
        XCTAssertEqual(stack.axis, .horizontal)
        XCTAssertFalse(stack.isBaselineRelativeArrangement)
        XCTAssertEqual(stack.distribution, .fill)
        XCTAssertEqual(stack.spacing, 0)
        XCTAssertNil(stack.backgroundColor)
    }

}
