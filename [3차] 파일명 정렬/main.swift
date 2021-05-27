//
//  main.swift
//  [3차] 파일명 정렬
//
//  Created by 진형진 on 2021/05/23.
//

import Foundation


func solution(_ files:[String]) -> [String] {
    let numbers: CharacterSet = ["0","1","2","3","4","5","6","7","8","9"]
    let numbersString: [Character] = ["0","1","2","3","4","5","6","7","8","9"]
    var headNumberInputOrder = [(head: String, number: Int, idx: Int)]()
    var answer = [String]()
    
    for idx in 0..<files.count {
        // file[idx] = "foo010bar020.zip"
        let fileComponents =  files[idx].components(separatedBy: numbers)
        var temp = [String]()
        // fileComponents = ["foo","" ,"" ,"" ,"bar" ,"" ,"" ,"" ,".zip"]
        for component in fileComponents {
            if component != "" {
                temp.append(component)
            }
        }
        // temp = ["foo", "bar", ".zip"]
        
        let head = temp[0]
        var number = ""
        let removeHead = files[idx].replacingOccurrences(of: head, with: "")
        
        // removeHead = "010bar020.zip"
        
        for nums in removeHead {
            if numbersString.contains(nums) {
                number += String(nums)
            } else {
                break
            }
        }
        
  
        
        // ("FOO", 10, 0) 로 저장 (대문자화한 HEAD, NUMBER, 입력순서)
        headNumberInputOrder.append((head.uppercased(), Int(number)!, idx))
    }
    
    // 기준에 맞게 정렬
    headNumberInputOrder.sort {
        if $0.head == $1.head {
            if $0.number == $1.number {
                return $0.idx < $1.idx
            }
            return $0.number < $1.number
        }
        return $0.head < $1.head
    }
    
    // 배열을 탐색하며 answer에 정렬 순서대로 저장
    for tuple in headNumberInputOrder {
        answer.append(files[tuple.2])
    }
    
    return answer
}
let _ = solution(["F-5 Freedom Fighter", "B-50 Superfortress", "A-10 Thunderbolt II", "F-14 Tomcat"])

let numeric: ClosedRange<Character> = "0"..."9"
let head = "foo010bar020.zip".prefix{numeric.contains($0) == false}
let number = "foo010bar020.zip".drop {numeric.contains($0) == false}.prefix{numeric.contains($0) == true}

print("head: \(head) number: \(number)")



