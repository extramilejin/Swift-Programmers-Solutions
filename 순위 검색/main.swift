//
//  main.swift
//  순위 검색
//
//  Created by 진형진 on 2021/05/28.
//

import Foundation

func solution(_ info:[String], _ query:[String]) -> [Int] {
    var dic: [String : [Int]] = [:]
    var answer = [Int]()
    
    func combination(_ arr: [String], _ curIdx: Int, _ score: Int) {
        if curIdx == arr.count {
            print(arr)
            let result = arr.joined()
            if dic[result] != nil {
                dic[result]!.append(score)
            } else {
                dic[result] = [score]
            }
        } else {
            var temp = arr
            combination(temp, curIdx + 1, score)
            temp[curIdx] = "-"
            combination(temp, curIdx + 1, score)
        }
        return
    }
    
    func lowerbound(_ arr: [Int], _ score: Int) -> Int {
        var low = 0
        var high = arr.count
        
        while low < high {
            let mid = (low + high) / 2
            if score <= arr[mid] {
                high = mid
            } else {
                low = mid + 1
            }
        }
        // low = score 이상의 점수가 처음 등장하는 인덱스
        return arr.count - low
    }
    
    for applicant in info {
        var components = applicant.components(separatedBy: " ")
        let score = Int(components[4])!
        components.removeLast()
        combination(components, 0, score)
    }
    
    // 이분탐색을 위해 미리 점수배열을 정렬
    for (query, scores) in dic {
        let sortedScores = scores.sorted(by: <)
        dic[query] = sortedScores
    }

    for q in query {
        var components = q.components(separatedBy: " ").filter{$0 != "and"}
        let score = Int(components[4])!
        components.removeLast()
        let key = components.joined()
        
        if dic[key] == nil {
            answer.append(0)
        } else {
            answer.append(lowerbound(dic[key]!, score))
        }
    }
    return answer
}



let _ = solution(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"])
