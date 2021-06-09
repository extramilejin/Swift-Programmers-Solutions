//
//  main.swift
//  섬 연결하기
//
//  Created by 진형진 on 2021/06/07.
//

import Foundation

func solution(_ n:Int, _ costs:[[Int]]) -> Int {
    var graph = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    var tree = [Bool](repeating: false, count: n)
    var mstCost = 0
    // 최소힙역할 배열
    var pq: [(cost: Int, idx: Int)] = []
    
    for info in costs {
        let from = info[0]
        let to = info[1]
        let cost = info[2]
        
        graph[from][to] = cost
        graph[to][from] = cost
    }
    
    // 0번째 섬을 시작점으로 하고 최소힙에 인접한 섬의 연결비용과 섬의 인덱스를 넣어준다.
    tree[0] = true
    
    for idx in 0..<n {
        if graph[0][idx] != 0 {
            pq.append((graph[0][idx], idx))
        }
    }
    
    while !pq.isEmpty {
        // 비용을 기준으로 오름차순 정렬
        pq.sort{$0.cost < $1.cost}
        let cur = pq.first!.idx
        let curCost = pq.first!.cost
        pq.removeFirst()
        // tree에 포함되어있지 않다면 추가하고 최소힙에 인접한 섬들을 넣어준다.
        if tree[cur] == false {
            tree[cur] = true
            // 최소 비용 추가
            mstCost += curCost
            for idx in 0..<n {
                if tree[idx] == false && graph[cur][idx] != 0 {
                    pq.append((graph[cur][idx], idx))
                }
            }
        }
    }
    
    return mstCost
}

let _ = solution(4,[[0,1,1],[0,2,2],[1,2,5],[1,3,1],[2,3,8]])

