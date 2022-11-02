//
//  Extensions.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-09-29.
//

import Foundation
import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

extension Date {
    func convertDateToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .short, timeStyle: .none)
    }
    
    func convertTimeToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
    }
}
