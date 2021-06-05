//
//  main.swift
//  신규 아이디 추천
//
//  Created by 진형진 on 2021/05/31.
//

import Foundation

func solution(_ new_id:String) -> String {
    let numeric: ClosedRange<Character> = "0"..."9"
    let alphabet: ClosedRange<Character> = "a"..."z"
    let symbols: [Character] = [".","-","_"]
    
    func filtering(_ c: Character) -> Bool {
        return numeric.contains(c) || alphabet.contains(c) || symbols.contains(c)
    }
    
    // 소문자로 치환, 가능한 문자들만 필터링
    var recommended = new_id.lowercased().filter{filtering($0)}
    
    // "."가 두개 이상 이어저서 존재하면 "."로 변환
    while recommended.contains("..") {
       recommended = recommended.replacingOccurrences(of: "..", with: ".")
    }
    
    // 아이디의 처음과 끝에 "."가 존재하면 제거
    while recommended.hasPrefix(".") {
        recommended.removeFirst()
    }
    
    while recommended.hasSuffix(".") {
        recommended.removeLast()
    }
    
    // 빈 문자열일 경우 "a"
    if recommended.isEmpty {
        recommended = "a"
    }
    
    // 아이디의 길이가 16이상일 때 끊어서 처리
    if recommended.count >= 16 {
        let temp = recommended.map{$0}
        if temp[14] == "." {
            recommended = String(temp[0...13])
        } else {
            recommended = String(temp[0...14])
        }
    }
    
    // 길이가 2이하일 경우 마지막 문자를 길이가 3이 될 때까지 이어서 붙힌다.
    if recommended.count <= 2 {
        while recommended.count != 3 {
            recommended += String(recommended.last!)
        }
    }
    
    return recommended
}


let _ = solution("...!@BaT#*..y.abcdefghijklm")
