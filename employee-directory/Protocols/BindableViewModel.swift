//
//  ViewModel.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Foundation

protocol BindableViewModel {
    var store: Store<AppState, AppAction, CoordinatorAction> { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    init(store: Store<AppState, AppAction, CoordinatorAction>)
}

enum ViewState {
    case notLoaded
    case loading
    case completed
    case incomplete
    case error(String?)
}
