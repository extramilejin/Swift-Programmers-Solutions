//
//  main.swift
//  [3차] n진수 게임
//
//  Created by 진형진 on 2021/05/26.
//

import Foundation

func solution(_ n:Int, _ t:Int, _ m: Int, _ p:Int) -> String {
    var answer = ""
    var turn = 1
    var integer = 0
    
    while answer.count < t {
        let convertedByBaseN = String(integer, radix: n, uppercase: true)
        
        for number in convertedByBaseN {
            if turn == p {
                answer += String(number)
            }
            
            if turn == m {
                turn = 0
            }
            
            if answer.count == t {
                break
            }
            
            turn += 1
        }
        integer += 1
    }
    return answer
}

// 1 2 3 4 5 6 7 1 2 3 4 5 6 7 -> 반복
// cnt % 7 cnt == m


let _ = print(solution(2,4,2,1))

