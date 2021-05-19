//
//  main.swift
//  메뉴 리뉴얼
//
//  Created by 진형진 on 2021/05/14.
//

import Foundation

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    
    return []
}

func compare(_ str1: String, _str2: String) {
    
}

let _ = solution(["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"],[2,3,4])

/*
A B C D E F G               A B C D E F G H
                          A   1 4 3 3 2 2 1
                          B     2     2 2
                          C       3 3 2 2 1
                          D         3     1
                          E               1
                          F             2
                          G
                          
                        DFS(A,count)
                        DFS(A,count)
                        AC - 4
                        ACD - 함께등장하지
 
 
 각각 비교 이중포문
                        
A   C
    C D E
A   C D E
A B C     F G
  B C     F G
A   C D E     H
 
4 2 6 3 3 2 2 1

C - [1,2,3,4,5,6]
A - [1,3,4,6]
D - [2,3,6]
E - [2,3,6]
B - [4,5]
F - [4,5]
G - [4,5]
H - [6]

 


 
 */
