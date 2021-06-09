//
//  main.swift
//  광고 삽입
//
//  Created by 진형진 on 2021/06/05.
//

import Foundation

func solution(_ play_time:String, _ adv_time:String, _ logs:[String]) -> String {
    
    func convertTimeToSecond(_ time: String) -> Int {
        let components = time.components(separatedBy: ":")
        return Int(components[0])! * 3600 + Int(components[1])! * 60 + Int(components[2])!
    }
    
    func convertSecondToTime(_ second: Int) -> String {
        let h = second / 3600
        let m = ((second % 3600) / 60)
        let s = ((second % 3600) % 60)
        return String(format: "%02d:%02d:%02d",h,m,s)
    }
    
    let playSecond = convertTimeToSecond(play_time)
    let advSecond = convertTimeToSecond(adv_time)
    var accumulated = [Int](repeating: 0, count: playSecond + 1)
    
    for log in logs {
        let components = log.components(separatedBy: "-")
        let logStart = convertTimeToSecond(components[0])
        let logEnd = convertTimeToSecond(components[1])
        accumulated[logStart] += 1
        accumulated[logEnd] -= 1
    }
    
    for idx in 1...playSecond {
        accumulated[idx] += accumulated[idx - 1]
    }
    
    for idx in 1...playSecond {
        accumulated[idx] += accumulated[idx - 1]
    }
    
    var maxVal = accumulated[advSecond]
    var maxSumtime = 0
    
    for start in 1...playSecond {
        var end = 0
        if start + advSecond < playSecond {
            end = start + advSecond
        } else {
            end = playSecond
        }
        let sumPlayed = accumulated[end] - accumulated[start]
        
        if maxVal < sumPlayed {
            maxVal = sumPlayed
            maxSumtime = start + 1
        }
    }
    print(convertSecondToTime(maxSumtime))
    return convertSecondToTime(maxSumtime)
}

let _ = solution("02:03:55", "00:14:15", ["01:20:15-01:45:14", "00:40:31-01:00:00", "00:25:50-00:48:29", "01:30:59-01:53:29", "01:37:44-02:02:30"])
