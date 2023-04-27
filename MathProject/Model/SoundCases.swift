//
//  SoundPlayerCasesEnum.swift
//  MathProject
//
//  Created by Iryna Rarova on 24.04.2023.
//

import Foundation
enum SoundCases {
    case correctAnswer
    case vrongAnswer
    case taskCompleted
    case noMistake
    
    var description: String {
        switch self {
        case .correctAnswer: return "correctAnswer"
        case .vrongAnswer: return "vrongAnswer"
        case .taskCompleted: return "taskCompleted"
        case .noMistake: return "noMistake"
        }
    }
}
