//
//  EmployeeListViewModelTests.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

import Combine
@testable import employee_directory
import XCTest

class EmployeeListViewModelTests: XCTestCase {
    var store: Store<AppState, AppAction, CoordinatorEffect>!
    var coordinator: AppCoordinator!
    var viewModel: EmployeeListViewModel!

    func testGetAllEmployeesRequestSucceeds() {
        store = Store(initialValue: .initial, reducer: appReducer)
        coordinator = AppCoordinator(navigationController: MockNavigationController(),
                                         store: store)
        viewModel = EmployeeListViewModel(store: store,
        getEmployeeRequestProvider: MockGetEmployeesRequestSuccess())
        viewModel.retrieveAllEmployees()
        XCTAssertEqual(viewModel.store.value.employees, Mocks.twoEmployees)
        XCTAssertEqual(viewModel.viewState, .completed)
    }
    
    func testGetAllEmployeesRequestFails() {
        store = Store(initialValue: .initial, reducer: appReducer)
        coordinator = AppCoordinator(navigationController: MockNavigationController(),
                                         store: store)
        viewModel = EmployeeListViewModel(store: store,
        getEmployeeRequestProvider: MockGetEmployeesRequestFail())
        viewModel.retrieveAllEmployees()
        XCTAssertTrue(viewModel.store.value.employees.isEmpty)
        if case let .error(message) = viewModel.viewState {
            XCTAssertNotNil(message)
        } else {
            XCTFail("ViewState.error expected. \(viewModel.viewState) received.")
        }
    }
}

fileprivate struct MockGetEmployeesRequestSuccess: GetEmployeesRequestProvider {
    func request() -> GetEmployeesRequestProvider {
        return MockGetEmployeesRequestSuccess()
    }
    
    typealias ResponseType = GetEmployeesResponse
    func execute(urlSession: URLSession) -> AnyPublisher<GetEmployeesResponse, NetworkError> {
        return Just(GetEmployeesResponse(employees: Mocks.twoEmployees))
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}

fileprivate struct MockGetEmployeesRequestFail: GetEmployeesRequestProvider {
    func request() -> GetEmployeesRequestProvider {
        return MockGetEmployeesRequestFail()
    }
    
    typealias ResponseType = GetEmployeesResponse
    func execute(urlSession: URLSession) -> AnyPublisher<GetEmployeesResponse, NetworkError> {
        return Fail(error: NetworkError.apiError("400")).eraseToAnyPublisher()
    }
}
