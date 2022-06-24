//
//  ViewModel.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Foundation

protocol BindableViewModel {
    var store: Store<AppState, AppAction, CoordinatorEffect> { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    init(store: Store<AppState, AppAction, CoordinatorEffect>)
}

enum ViewState {
    case notLoaded
    case loading
    case completed
    case incomplete
    case error(String?)
}
