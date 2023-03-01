//
//  SystemPropertyEx.swift
//  SwiftUIImplementation
//
//  Created by BinYu on 1/3/2023.
//

import Foundation
import SwiftUI

extension HorizontalAlignment {
    private enum HeightAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height //New alignment to return the height of the view
        }
    }
    
    //Fast access
    static let heightAlignment = HorizontalAlignment(HeightAlignment.self)
}
