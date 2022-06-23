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
    
    static var initial = AppState(employees: [Employee]())
}

// Very much inspired from the Composable Architecture/Point Free team. A similar/simplified version of their architecture adapted for UIKit
class Store<Value, Action> {
    let reducer: (inout Value, Action) -> Void
//    weak var coordinator: Coordinator?
    
    @Published private(set) var value: Value

    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.reducer = reducer
        self.value = initialValue
    }

    func send(_ action: Action) {
        self.reducer(&self.value, action)
    }
}

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    case let .employeeSelected(employee):
        return
    case let .setEmployees(employees):
        state.employees = employees
    }
}

enum AppAction {
    case employeeSelected(Employee)
    case setEmployees([Employee])
}
