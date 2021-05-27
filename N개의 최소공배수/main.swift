//
//  main.swift
//  N개의 최소공배수
//
//  Created by 진형진 on 2021/05/20.
//

import Foundation

func solution(_ arr:[Int]) -> Int {
    // 유클리드 호제법을 통해 최대공약수를 구하는 함수
    func gcdOfTwoNumbers(_ a: Int, _ b: Int) -> Int {
        let r = a % b
        
        if r != 0 {
            return gcdOfTwoNumbers(b, r)
        } else {
            return b
        }
    }
    // 최소 공배수를 구하는 함수
    func lcmOfTwoNumbers(_ a: Int, _ b: Int) -> Int {
        return a * b / gcdOfTwoNumbers(a, b)
    }
    
    // 1과 자기자신의 최소 공배수는 자기 자신임으로 1로 초깃값을 설정하고
    // reduce
    return arr.reduce(1){lcmOfTwoNumbers($0, $1)}
}

print(solution([2,6,8,14]))
print(Int.max)


