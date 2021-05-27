//
//  main.swift
//  가장 큰 정사각형 찾기
//
//  Created by 진형진 on 2021/05/21.
//

import Foundation

func solution(_ board:[[Int]]) -> Int
{
    var maxVal = 0
    var square = board
    
    // 행의 크기가 1이거나 열의 크기가 1인경우
    if board.count == 1 || board.filter({$0.count > 1}).count == 0 {
        // 1을 하나라도 포함 하면 return 1
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j] == 1 {
                    return 1
                }
            }
        }
        // 그렇지 않다면 0
        return 0
    }
    
    for row in 1..<board.count {
        for col in 1..<board[row].count {
            // 해당 좌표가 1이라면
            if board[row][col] == 1 {
                // 세 좌표를 우하단으로 하는 정사각형의 크기가 모두 동일할 경우 그 값을 더해준다.
                square[row][col] += min(square[row-1][col], square[row-1][col-1], square[row][col-1])
                maxVal = max(maxVal, square[row][col])
            }
        }
    }
    // 제곱하여 크기를 구한다.
    return maxVal * maxVal
}

print(solution([[0]]))
