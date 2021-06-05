//
//  main.swift
//  다단계 칫솔판매
//
//  Created by 진형진 on 2021/06/01.
//

import Foundation

func solution(_ enroll:[String], _ referral:[String], _ seller:[String], _ amount:[Int]) -> [Int] {
    // [판매원 : 추천인] , [판매원 : 수익금]
    var connections = Dictionary<String, String>()
    var profits = Dictionary<String, Int>()
    profits["-"] = 0
    
    // 분배금 계산, Int 생성자로 절사 처리
    func calculate(_ profit: Int) -> Int {
        return Int(Double(profit) * 0.1)
    }

    // 분배금 전달 함수
    func pass(_ name: String, earn: Int) {
        // 수익금이 0에 수렴하면 더 이상 전달하는 의미가 없으므로, return
        if earn == 0 {
            return
        }
        
        // 수익금 전달
        profits[name]! += earn
        if name != "-" {
            // 자신을 추천한 추천인이 존재하면 10%를 제한 금액은 가지고 분배금을 넘긴다.
            profits[name]! -= calculate(earn)
            pass(connections[name]!, earn: calculate(earn))
        }
    }
    
    // 딕셔너리 초기화
    for i in 0..<enroll.count {
        connections[enroll[i]] = referral[i]
        profits[enroll[i]] = 0
    }
    
    // 수익금이 발생한 노드들로 부터 분배금을 먼저 계산하고 자신의 판매 수익을 더해 준다.
    for i in 0..<seller.count {
        pass(connections[seller[i]]!, earn: calculate(amount[i] * 100))
        // 이미 분배를 해준 상황이므로 100 * 0.9 = 90
        profits[seller[i]]! += amount[i] * 90
    }
   
    // enroll 입력 순서대로 수익금을 매핑
    return enroll.map{profits[$0]!}
}

print(solution(["john", "mary", "edward", "sam", "emily", "jaimie", "tod", "young"]
                 , ["-", "-", "mary", "edward", "mary", "mary", "jaimie", "edward"]
                 , ["young", "john", "tod", "emily", "mary"]
                 , [12, 4, 2, 5, 10]))

