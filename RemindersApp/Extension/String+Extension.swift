//
//  String+Extension.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
