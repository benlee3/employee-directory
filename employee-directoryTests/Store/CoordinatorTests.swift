//
//  CoordinatorTests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

class CoordinatorTests: XCTestCase {
    var store: Store<AppState, AppAction, CoordinatorEffect>!
    var coordinator: AppCoordinator!
    var mockNavigationController: MockNavigationController!
    
    override func setUpWithError() throws {
        store = Store(initialValue: Mocks.initialStoreValueWithEmployee, reducer: appReducer)
        coordinator = AppCoordinator(navigationController: MockNavigationController(),
                                         store: store)
        guard let mockNavController = coordinator.navigationController as? MockNavigationController else { return XCTFail("Could not create MockNavigationController") }
        mockNavigationController = mockNavController
    }

    func testShowList() {
        let _ = coordinator.handleAction(action: .showList)
        XCTAssertEqual(mockNavigationController.pushedViewControllers.count, 1)
        XCTAssertTrue(mockNavigationController.pushedViewControllers.contains { type(of: $0) == EmployeeListViewController.self })
    }
    
    func testShowEmployee() {
        let _ = coordinator.handleAction(action: .showEmployee(0))
        XCTAssertEqual(mockNavigationController.presentedViewControllers.count, 1)
        XCTAssertTrue(mockNavigationController.presentedViewControllers.contains { type(of: $0) == EmployeeDetailViewController.self })
    }

}
