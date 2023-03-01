//
//  LinkView.swift
//  SwiftUIImplementation
//
//  Created by BinYu on 1/3/2023.
//

import Foundation
import SwiftUI

struct LinkeView: Identifiable {
    var id = UUID()
    let linkName: String
    let linkView: AnyView
}
