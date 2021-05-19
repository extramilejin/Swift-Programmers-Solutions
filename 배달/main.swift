//
//  main.swift
//  배달
//
//  Created by 진형진 on 2021/05/19.
//

import Foundation

func solution(_ N:Int, _ road:[[Int]], _ k:Int) -> Int {
    // 1번 마을로 부터 각 마을까지의 최단 거리를 갱신할 배열, 최대값으로 초기화 합니다.
    var distsFromFirstVillage = [Int](repeating: Int.max, count: N + 1)
    
    // 그래프는 인접행렬의 형태로 구현하고 행렬 값을 이동하는 데 소요되는 시간으로 표한합니다.
    // 값이 0 인경우 경로가 존재하지 않습니다.
    var graph = [[Int]](repeating: [Int](repeating: 0, count: N + 1), count: N + 1)
    
    for data in road {
        let from = data[0]
        let to = data[1]
        let cost = data[2]
        
        if graph[from][to] == 0 {
            graph[from][to] = cost
            graph[to][from] = cost
        } else {
            // 문제에서 한 마을에서 다른 마을까지의 경로가 여러 개 존재할 수 있다고 했습니다.
            // 그러나 최단 거리만을 판단하면 되므로 소요 시간이 가장 짧은 값으로 갱신해 줍니다.
            if cost < graph[from][to] {
                graph[from][to] = cost
                graph[to][from] = cost
            }
        }
        
    }
    
    // 다익스트라 함수
    func dijkstara(start: Int) {
        var queue = [(Int, Int)]()
        // 시작점 거리 0으로 초기화
        distsFromFirstVillage[start] = 0
        
        queue.append((1,distsFromFirstVillage[1]))
        
        while !queue.isEmpty {
            let cur = queue.first!.0
            let cost = queue.first!.1
            queue.removeFirst()
            for next in 1...N {
                // 경로가 존재하고 더 짧은 이동 소요 시간일 경우 배열을 갱신합니다.
                if graph[cur][next] != 0 && cost + graph[cur][next]  < distsFromFirstVillage[next] {
                    distsFromFirstVillage[next] = cost + graph[cur][next]
                    queue.append((next, distsFromFirstVillage[next]))
                }
            }
        }
    }
    
    dijkstara(start: 1)
    
    return distsFromFirstVillage.filter{$0 <= k}.count
}

let answer = solution(5, [[1,2,1],[2,3,3],[5,2,2],[1,4,2],[5,3,1],[5,4,2]], 3)
print(answer)

