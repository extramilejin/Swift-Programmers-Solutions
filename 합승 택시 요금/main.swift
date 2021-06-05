//
//  main.swift
//  합승 택시 요금
//
//  Created by 진형진 on 2021/06/01.
//

import Foundation

func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    // 최대 요금, 최대요금으로 인접 매트릭스 초기화
    let maxFare = 200 * 100000
    var graph = [[Int]](repeating: [Int](repeating: maxFare, count: n + 1), count: n + 1)
    var answer = Int.max

    for fare in fares {
        let from = fare[0]
        let to = fare[1]
        let cost = fare[2]
        
        // 양방향 그래프
        graph[from][to] = cost
        graph[to][from] = cost
    }
    // 자기 자신까지의 요금는 0
    for node in 1...n {
        graph[node][node] = 0
    }

    // 플로이드 와샬
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                graph[i][j] = min(graph[i][j], graph[i][k] + graph[k][j])
            }
        }
    }
    // 중간지점을 하나씩 설정하여 최솟값을 구함. 출발지에서 각자 출발하는 경우도 포함 (mid == s)
    for mid in 1...n {
        answer = min(answer, graph[s][mid] + graph[mid][a] + graph[mid][b])
    }

    return answer
}

let _ = solution(6,4,5,6,[[2,6,6], [6,3,7], [4,6,7], [6,5,11], [2,5,12], [5,3,20], [2,4,8], [4,3,9]])
