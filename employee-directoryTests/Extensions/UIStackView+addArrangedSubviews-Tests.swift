//
//  UIStackView+addArrangedSubviews-Tests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

class UIStackView_addArrangedSubviews_Tests: XCTestCase {

    func testAddArrangedSubviews() {
        let stack = UIStackView()
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        stack.addArrangedSubviews(view1, view2, view3)
        XCTAssertEqual(stack.arrangedSubviews.count, 3)
        XCTAssertEqual(stack.arrangedSubviews.first!, view1)
    }

}
