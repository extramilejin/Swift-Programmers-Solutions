//
//  main.swift
//  뉴스 클러스터링
//
//  Created by 진형진 on 2021/05/18.
//

import Foundation

func solution(_ str1:String, _ str2:String) -> Int {
    // 대소문자를 구별하지 않기 위해 String의 타입메서드인 uppercased()를 사용하여 대문자로 통일합니다.
    // .map{$0}을 사용하여 추후 두 문자씩 묶어주기 위한 작업이 편하도록 배열로 변환합니다.
    let capitalStr1 = str1.uppercased().map{$0}
    let capitalStr2 = str2.uppercased().map{$0}
    
    // 교집합,합집합 배열
    var intersection = [String]()
    var union = [String]()
    
    // String과 Tuple을 Key, Value로 가지는 딕셔너리입니다.
    // 튜플의 첫 번째 값은 해당 Key인 문자를 A에서 포함하는 개수이고
    // 두 번째 값은 B에서 포함하는 개수를 의미합니다.
    var countDict: Dictionary<String, (Int, Int)> = [:]
    
    // 대문자 알파벳만 필터링 하기 위한 함수
    func isAlphabet(_ character: Character) -> Bool {
        return character >= "A" && character <= "Z"
    }
    // 입력받은 첫 번째 문자열을 통해 다중 집합 A를 딕셔너리에 저장합니다.
    // 따라서 튜플의 첫 번째 값에 포함 개수를 저장합니다.
    for idx in 0..<capitalStr1.count - 1 {
        // 알파벳이 아닌 문자를 포함하면 continue
        if isAlphabet(capitalStr1[idx]) == false || isAlphabet(capitalStr1[idx+1]) == false {
            continue
        }
        // 두 문자를 묶어서 딕셔너리에 저장
        let temp = "\(capitalStr1[idx])\(capitalStr1[idx+1])"
        // 존재하는 경우 포함 개수 += 1, 없는 경우 (1, 0)
        if countDict[temp] != nil {
            countDict[temp]!.0 += 1
        } else {
            countDict[temp] = (1, 0)
        }
    }
    // 입력받은 두 번째 문자열을 통해 다중 집합 B를 딕셔너리에 저장합니다.
    // 따라서 튜플의 두 번째 값에 포함 개수를 저장합니다.
    for idx in 0..<capitalStr2.count - 1 {
        if isAlphabet(capitalStr2[idx]) == false || isAlphabet(capitalStr2[idx+1]) == false {
            continue
        }
        
        let temp = "\(capitalStr2[idx])\(capitalStr2[idx+1])"
        
        if countDict[temp] != nil {
            countDict[temp]!.1 += 1
        } else {
            countDict[temp] = (0, 1)
        }
    }
    // 딕셔너리가 비어있는 경우 A, B 모두 공집합을 의미하므로 자카드 유사도를 1로 정의하고 리턴합니다.
    if countDict.isEmpty {
        return 1 * 65536
    }
    
    // 딕셔너리를 탐색하며 포함개수를 비교하여 교집합과 합집합에 해당 문자를 넣어줍니다.
    for (key, value) in countDict {
        let maxVal = max(value.0, value.1)
        let minVal = min(value.0, value.1)
        for _ in 0..<maxVal {
            union.append(key)
        }
        for _ in 0..<minVal {
            intersection.append(key)
        }
    }
    // 65536값을 곱해준뒤 정수부만 취하기 위해 Int()생성자를 사용하여 리턴합니다.
    return Int(Double(intersection.count)/Double(union.count) * 65536)
}


