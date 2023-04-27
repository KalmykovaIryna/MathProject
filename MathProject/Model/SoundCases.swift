//
//  SoundPlayerCasesEnum.swift
//  MathProject
//
//  Created by Iryna Rarova on 24.04.2023.
//

import Foundation
enum SoundCases {
    case correctAnswer
    case wrongAnswer
    case taskCompleted
    case noMistake
    
    var description: String {
        switch self {
        case .correctAnswer: return "correctAnswer"
        case .wrongAnswer: return "wrongAnswer"
        case .taskCompleted: return "taskCompleted"
        case .noMistake: return "noMistake"
        }
    }
}
