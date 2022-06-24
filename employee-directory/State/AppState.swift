//
//  AppState.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Foundation

struct AppState {
    var employees: [Employee]
    var selectedEmployee: Employee?
    
    static var initial = AppState(employees: [Employee]())
}

// Very much inspired from the Composable Architecture/Point Free team. A similar/simplified version of their architecture adapted for UIKit
class Store<Value, Action, NavSideEffect> {
    let reducer: (inout Value, Action) -> NavSideEffect?
    weak var coordinator: Coordinator?
    
    @Published private(set) var value: Value

    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> NavSideEffect?) {
        self.reducer = reducer
        self.value = initialValue
    }

    func send(_ action: Action) {
        self.reducer(&self.value, action)
//        if let coordinatorAction = self.reducer(&self.value, action) {
//            coordinator?.handleAction(action: coordinatorAction)
//        }
    }
}

func appReducer(state: inout AppState, action: AppAction) -> CoordinatorAction? {
    switch action {
    case let .employeeSelected(index):
        state.selectedEmployee = state.employees[index]
        return nil
    case let .setEmployees(employees):
        state.employees = employees
        return nil
    }
}

enum AppAction {
    case employeeSelected(Int)
    case setEmployees([Employee])
}
