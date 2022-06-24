//
//  Collection+safeIndex.swift
//  employee-directory
//
//  Created by Ben Lee on 6/24/22.
//
// https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings

import Foundation
import SwiftUI

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
