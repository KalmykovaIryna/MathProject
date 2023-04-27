//
//  File.swift
//  MathProject
//
//  Created by Iryna Rarova on 02.02.2023.
//

import Foundation
import UIKit

enum CellStatus {
    case active
    case notActive
    case notPayed
    
    var statusButtonImage: UIImage? {
        switch self {
        case .active: return UIImage(named: "statusButtonActive")
        case .notActive: return UIImage(named: "statusButtonNotActive")
        case .notPayed: return UIImage(named: "statusButtonNotPayed")
        }
    }
}
