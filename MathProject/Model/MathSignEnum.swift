//
//  MathSignEnum.swift
//  MathProject
//
//  Created by Iryna Rarova on 30.11.2022.
//

import Foundation

enum MathSignEnum {
    case minus
    case plus
    case division
    case multiply
    case none
    
    var descriptionSign: String {
        switch self {
        case .minus: return "-"
        case .plus: return "+"
        case .division: return "/"
        case .multiply: return "x"
        case .none: return ""
        }
    }
    
    var descriptionText: String {
        switch self {
        case .minus: return "minus"
        case .plus: return "plus"
        case .division: return "division"
        case .multiply: return "multiply"
        case .none: return ""
        }
    }
    
    func calculateForPlus(number: Int, number2: Int) -> Int {
        var result =  0
        result = number + number2
        return result
    }
    
    func calculateForMultiply(number: Int, number2: Int) -> Int {
        var result =  0
        result = number * number2
        return result
    }
    
    func calculateForMinus(number: Int, number2: Int) -> Int {
        var result =  0
        if number > number2 {
            result = number - number2
        }else {
            result = number2 - number
        }
        return result
    }
    
    func calculateForDivision(number: Int, number2: Int) -> Int {
        var result =  0
        let resultOfMultiply = number * number2
        result = resultOfMultiply / number
        return result
    }
    
    func calculate(number: Int, number2: Int) -> Int {
        switch self {
        case .plus: return calculateForPlus(number: number, number2: number2)
        case .multiply: return calculateForMultiply(number: number, number2: number2)
        case .minus: return calculateForMinus(number: number, number2: number2)
        case .division: return calculateForDivision(number: number, number2: number2)
        case .none: return 0
        }
    }
}
