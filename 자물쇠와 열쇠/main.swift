//
//  main.swift
//  자물쇠와 열쇠
//
//  Created by 진형진 on 2021/06/03.
//

import Foundation

func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    let M = key.count
    let N = lock.count
    // 3 * N X 3 * N 으로 확장시킨 자물쇠 행렬
    var extendedLock = [[Int]](repeating: [Int](repeating: 0, count: 3 * N), count: 3 * N)
    // 확장된 행렬에서 원래의 자물쇠행렬이 위치하는 범위
    let extendedRange = N..<2 * N

    // 90도 시계방향 회전
    func rotateKey90DegreesClockwise(_ key: [[Int]]) -> [[Int]] {
        var rotatedKey = [[Int]](repeating: [Int](repeating: 0, count: M), count: M)
        for col in 0..<M {
            for row in (0..<M).reversed() {
                rotatedKey[col][M - 1 - row] = key[row][col]
            }
        }
        return rotatedKey
    }
    // 확장된 행렬에서 자물쇠위치를 탐색하며 열리는지 판단
    func canOpen(_ lock: [[Int]]) -> Bool {
        for i in extendedRange {
            for j in extendedRange {
                // 0 이 존재하면 채워지지 않은 홈, 2이면 돌기끼리 만난 경우 false 리턴
                if lock[i][j] != 1 {
                    return false
                }
            }
        }
        return true
    }
    
    // 입력받았을 때, 자물쇠가 모두 1인 경우 열려있으므로 true 리턴
    if (lock.filter{$0.contains(0)}).isEmpty {
        return true
    }
    
    // 확장
    for i in 0..<N {
        for j in 0..<N {
            extendedLock[i + N][j + N] = lock[i][j]
        }
    }
    
    var tempKey = key
    var tempExtendedLock = extendedLock
    
    for _ in 0..<4 {
        for i in (N - M + 1)..<2 * N {
            for j in (N - M + 1)..<2 * N  {
                tempExtendedLock = extendedLock
                for row in 0..<M {
                    for col in 0..<M {
                        tempExtendedLock[i + row][j + col] += tempKey[row][col]
                    }
                }
                
                if canOpen(tempExtendedLock) {
                    return true
                }
            }
        }
        // 키를 회전시키면서 열리는지 체크
        tempKey = rotateKey90DegreesClockwise(tempKey)
    }
    return false
}

let _ = solution([[0, 0, 0], [1, 0, 0], [0, 1, 1]],  [[1, 1, 1], [1, 1, 0], [1, 0, 1]])
let second = solution([[0, 0],[0, 0]], [[1, 1],[1, 1]])

/*
 0 1 2
 0 1 2 3 4 5 6 7 9
 for row in 0..<M {
     for col in 0..<M {
         print(ret[row][col], terminator: " ")
     }
     print()
 }
 
 print("current key -----------")
 for row in 0..<N{
     for col in 0..<N {
         print(tempKey[row][col], terminator: " ")
     }
     print()
 }
 print("-----------------------")
 
 for _ in 0..<4 {
     temp = rotate(temp)
     for i in 0..<temp.count {
         for j in 0..<temp[0].count {
             print(temp[i][j], terminator: " ")
         }
         print()
     }
     print()
 }
 
 for row in 0..<3*M {
     for col in 0..<3*M {
         print(tempExtendedLock[row][col], terminator: " ")
     }
     print()
 }
 print()
 
 for row in 0..<3*M {
     for col in 0..<3*M {
         print(extendedLock[row][col], terminator: " ")
     }
     print()
 }
 print()
 
 for row in extendedRange {
     for col in extendedRange {
         print(extendedLock[row][col], terminator: " ")
     }
     print()
 }
 
 */
