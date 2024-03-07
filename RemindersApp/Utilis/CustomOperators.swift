//
//  CustomOperators.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>,rhs:T) -> Binding<T> {
    
    Binding(
        get: { lhs.wrappedValue ?? rhs},
        set: { lhs.wrappedValue = $0}
    )
}
