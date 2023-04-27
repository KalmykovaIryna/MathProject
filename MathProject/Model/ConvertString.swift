//
//  ConvertString.swift
//  MathProject
//
//  Created by Iryna Rarova on 13.01.2023.
//

import UIKit


class ConvertString {
    
     func stringInSignCases(number: Int, number2: Int, sign: MathSignEnum, isNeedEquals: Bool) -> String {
        switch sign {
        case .minus:
            if number > number2 {
                guard !isNeedEquals else { return "\(number) \(sign.descriptionSign) \(number2) = "}
                return "\(number) \(sign.descriptionSign) \(number2)"
            } else {
                guard !isNeedEquals else { return "\(number2) \(sign.descriptionSign) \(number) = "}
                return "\(number2) \(sign.descriptionSign) \(number)"
            }
        case .plus:
            guard !isNeedEquals else { return "\(number) \(sign.descriptionSign) \(number2) = "}
            return "\(number) \(sign.descriptionSign) \(number2)"
        case .division:
            let resultOfMultiply = number * number2
            guard !isNeedEquals else { return "\(resultOfMultiply) \(sign.descriptionSign) \(number) = "}
            return "\(resultOfMultiply) \(sign.descriptionSign) \(number)"
        case .multiply:
            guard !isNeedEquals else { return "\(number) \(sign.descriptionSign) \(number2) = " }
            return "\(number) \(sign.descriptionSign) \(number2)"
        case .none:
            return ""
        }
        
    }
    
     func convertString(sign: MathSignEnum,
                      number: Int,
                      number2: Int, isNeedEquals: Bool) -> String {
        guard isNeedEquals else { return stringInSignCases(number: number, number2: number2, sign: sign, isNeedEquals: false) }
        return stringInSignCases(number: number, number2: number2, sign: sign, isNeedEquals: true)
    }
    
//    static func stringForMultiply(number: Int, number2: Int, isNeedEquals: Bool) -> String {
//        var string: String = ""
//        let sign: MathSignEnum = .multiply
//        if isNeedEquals {
//            string = "\(number) \(sign.descriptionSign) \(number2) = "
//        } else {
//            string = "\(number) \(sign.descriptionSign) \(number2)"
//        }
//
//        return string
//    }
    
//    static func stringForDivision (number: Int, number2: Int,  isNeedEquals: Bool) -> String {
//        var string: String = ""
//        let sign: MathSignEnum = .division
//        let resultOfMultiply = number * number2
//        if isNeedEquals {
//            string = "\(resultOfMultiply) \(sign.descriptionSign) \(number) = "
//        } else {
//            string = "\(resultOfMultiply) \(sign.descriptionSign) \(number)"
//        }
//
//        return string
//    }
    
//    static func stringForMinus(number: Int, number2: Int, isNeedEquals: Bool) -> String {
//        var string: String = ""
//        let sign: MathSignEnum = .minus
//        if isNeedEquals {
//            if number > number2 {
//                string = "\(number) \(sign.descriptionSign) \(number2) = "
//            }else {
//                string = "\(number2) \(sign.descriptionSign) \(number) = "
//            }
//        } else {
//            if number > number2 {
//                string = "\(number) \(sign.descriptionSign) \(number2) "
//            }else {
//                string = "\(number2) \(sign.descriptionSign) \(number) "
//            }
//        }
//
//        return string
//    }
    
//    static func stringForPlus(number: Int, number2: Int, isNeedEquals: Bool) -> String {
//        var string: String = ""
//        let sign: MathSignEnum = .plus
//        if isNeedEquals {
//            string = "\(number) \(sign.descriptionSign) \(number2) = "
//        } else {
//            string = "\(number) \(sign.descriptionSign) \(number2) "
//        }
//        return string
//    }
    
//    static func convertString(sign: MathSignEnum,
//                      number: Int,
//                      number2: Int, isNeedEquals: Bool) -> String {
//        var string: String = ""
//        if isNeedEquals {
//            if sign == .multiply {
//                string = stringForMultiply(number: number, number2: number2, isNeedEquals: true)
//            }
//            else if sign == .plus {
//                string = stringForPlus(number: number, number2: number2, isNeedEquals: true)
//            }
//            else if sign == .minus {
//                string = stringForMinus(number: number, number2: number2, isNeedEquals: true)
//            }
//            else if sign == .division {
//                string = stringForDivision(number: number, number2: number2, isNeedEquals: true)
//            }
//            else if sign == .none {
//                string = ""
//            }
//            return string
//
//        } else {
//            if sign == .multiply {
//                string = stringForMultiply(number: number, number2: number2, isNeedEquals: false)
//            }
//            else if sign == .plus {
//                string = stringForPlus(number: number, number2: number2, isNeedEquals: false)
//            }
//            else if sign == .minus {
//                string = stringForMinus(number: number, number2: number2, isNeedEquals: false)
//            }
//            else if sign == .division {
//                string = stringForDivision(number: number, number2: number2, isNeedEquals: false)
//            }
//            else if sign == .none {
//                string = ""
//            }
//            return string
//        }
//    }
}
