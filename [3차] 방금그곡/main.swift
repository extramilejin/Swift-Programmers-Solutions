//
//  main.swift
//  [3차] 방금그곡
//
//  Created by 진형진 on 2021/05/27.
//

import Foundation

struct MusicInfo {
    let title: String
    let playtime: Int
    let score: String
    var playedMelody: String {
        let start = score.startIndex
        
        // 재생시간이 해당곡의 멜로디 보다 짧은 경우
        if playtime < score.count {
            return String(score[start...score.index(start, offsetBy: playtime)])
        }
        
        // 그렇지 않을 경우 나머지 연산을 통해 재생시간에 맞춰 재생된 멜로디 문자열을 반환
        return [String](repeating: score, count: playtime / score.count).joined()
            + String(score[start...score.index(start, offsetBy: playtime % score.count)])
    }
    
    init(_ title: String, _ playtime: Int, _ score: String) {
        self.title = title
        self.playtime = playtime
        self.score = score
    }
}

func solution(_ m:String, _ musicinfos:[String]) -> String {
    
    // 매칭된 음악 리스트를 저장할 배열
    var matchedMusicList: [(title: String, playtime: Int)] = []
    let formatter =  DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    // DateFormatter를 이용하여 재생시간을 분 단위로 구하는 함수
    
    func calculatePlaytime(_ start: String, _ end: String) -> Int {
        let startDate = formatter.date(from: start)!
        let endDate = formatter.date(from: end)!
        
        return Int(endDate.timeIntervalSince(startDate) / 60)
    }
    
    // 입력된 멜로디 문자열의 #노트들을 소문자로 변환하는 함수
    
    func convertSharpToLowcase(_ score: String) -> String {
        var convertedScore = score
        let notes = [("C#","c"), ("A#", "a"), ("D#", "d"), ("F#", "f"), ("G#", "g")]
        
        for note in notes {
            convertedScore = convertedScore.replacingOccurrences(of: note.0, with: note.1)
        }
        
        return convertedScore
    }
    
    for musicinfo in musicinfos {
        let components = musicinfo.components(separatedBy: ",")
        let convertedScore =  convertSharpToLowcase(components[3])
        let music = MusicInfo(components[2], calculatePlaytime(components[0], components[1]), convertedScore)
        
        // 매칭된 음악을 리스트에 저장
        if music.playedMelody.contains(convertSharpToLowcase(m)) {
            matchedMusicList.append((music.title, music.playtime))
        }
    }
    
    // 매칭된 음악이 없을 경우 "(None)" 리턴
    
    if matchedMusicList.isEmpty {
        return "(None)"
    }
    
    // 재생 시간, 입력순서에 맞춰 배열을 정렬, 재생시간이 긴 음악이 앞에 오도록 정렬
    
    let sorted = matchedMusicList.enumerated().sorted {
        if $0.element.playtime == $1.element.playtime {
            return $0.offset < $1.offset
        }
        return $0.element.playtime > $1.element.playtime
    }
    
    // 배열의 첫 번째 원소가 정답
    
    return sorted.first!.element.title
}

print(solution("ABC", ["12:00,12:14,HELLO,C#DEFGAB", "13:00,13:05,WORLD,ABCDEF"]))

