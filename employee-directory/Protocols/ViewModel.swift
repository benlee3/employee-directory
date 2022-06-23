//
//  ViewModel.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Foundation

protocol ViewModel {
    var store: Store<AppState, AppAction> { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
//    init()
    init(store: Store<AppState, AppAction>)
}

enum ViewState {
    case notLoaded
    case loading
    case completed
    case incomplete
    case error(String?)
}

//extension ViewModel {
//    init(store: Store<AppState, AppAction>) {
//        self.store = store
//        self.cancellables = Set<AnyCancellable>()
//    }
//}
