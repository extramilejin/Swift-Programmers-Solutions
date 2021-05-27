////
////  main.swift
////  [카카오인턴] 수식 최대화
////
////  Created by 진형진 on 2021/05/20.
////
//
//import Foundation
//
//extension String {
//    var eval: Int64? {
//        return NSExpression(format: self).expressionValue(with: nil, context: nil) as? Int64
//    }
//}
//
//func solution(_ expression: String) -> Int64 {
//    
//    func eval(_ expression: String) -> Int64 {
//        if expression.contains("+") {
//            let numbers = expression.split(separator: "+")
//            return Int64(numbers[0])! + Int64(numbers[1])!
//        }
//        if expression.contains("-") {
//            let numbers = expression.split(separator: "-")
//            return Int64(numbers[0])! - Int64(numbers[1])!
//        }
//        if expression.contains("*") {
//            let numbers = expression.split(separator: "*")
//            return Int64(numbers[0])! * Int64(numbers[1])!
//        }
//        return Int64(expression)!
//    }
//    var answer: Int64 = 0
//    let operators: [String] = ["+","-","*"]
//    let priorities = [["+","-","*"],
//                      ["+","*","-"],
//                      ["-","*","+"],
//                      ["-","+","*"],
//                      ["*","+","-"],
//                      ["*","-","+"]]
//    
//    func calcutate(_ priority: [String], _ idx: Int, _ expression: String) -> String {
//        // 우선순위가 가장 높은 연산자와 계산 가능한 이항식으로 단위가 되면 계산
//        if idx == 2 && expression.components(separatedBy: ["*","-","+"]).count <= 2  {
//            return String(eval(expression))
//        }
//        //
//        var calcultatedExpression = ""
//        if priority[idx] == "-" {
//            let splitedExpression = expression.split(separator: "-")
//            for i in 0..<splitedExpression.count {
//                if i != splitedExpression.count - 1 {
//                    calcultatedExpression += (calcutate(priority, idx + 1, String(splitedExpression[i])) + "-")
//                } else {
//                    calcultatedExpression += calcutate(priority, idx + 1, String(splitedExpression[i]))
//                }
//            }
//        }
//        
//        if priority[idx] == "+" {
//            let splitedExpression = expression.split(separator: "+")
//            for i in 0..<splitedExpression.count {
//                if i != splitedExpression.count - 1 {
//                    calcultatedExpression += calcutate(priority, idx + 1, String(splitedExpression[i])) + "+"
//                } else {
//                    calcultatedExpression += calcutate(priority, idx + 1, String(splitedExpression[i]))
//                }
//            }
//        }
//        
//        if priority[idx] == "*" {
//            let splitedExpression = expression.split(separator: "*")
//            for i in 0..<splitedExpression.count {
//                if i != splitedExpression.count - 1 {
//                    calcultatedExpression += (calcutate(priority, idx + 1, String(splitedExpression[i])) + "*")
//                } else {
//                    calcultatedExpression += calcutate(priority, idx + 1, String(splitedExpression[i]))
//                }
//            }
//        }
//        return String(eval(calcultatedExpression))
//    }
//    
//    for priority in priorities {
//        let result = calcutate(priority, 0, expression)
//        answer = max(answer, abs(Int64(result)!))
//    }
//    return answer
//}
//
//print(solution("100-200*300-500+20"))
////
//
