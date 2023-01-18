//
//  main.swift
//  BaekJoon#7569
//
//  Created by 김병엽 on 2023/01/18.
//
import Foundation

let input = readLine()!.split(separator: " ").map({ Int(String($0))! })
let x = input[0]
let y = input[1]
let h = input[2]

typealias Point = (Int, Int, Int, Int)
let dx = [-1,1,0,0,0,0]
let dy = [0,0,-1,1,0,0]
let dh = [0,0,0,0,-1,1]

var box: [[[Int]]] = Array(repeating: [], count: h)
var queue = [Point]()

for i in 0..<h {
    for _ in 0..<y {
        let tmp = readLine()!.split(separator: " ").map({ Int(String($0))! })
        box[i].append(tmp)
    }
}

var zeros: Int = 0
for k in 0..<h {
    for i in 0..<y {
        for j in 0..<x {
            // 0 갯수 추가
            if box[k][i][j] == 0 { zeros += 1 }
            else if box[k][i][j] == 1 { queue.append((k, i, j, 0)) }
        }
    }
}

if zeros == 0 {
    print(0)
    exit(0)
}

func solution() -> Int {
    var idx = 0
    var last = 0
    
    while queue.count > idx {
        let now = queue[idx]
        last = now.3
        idx += 1
        
        for i in 0..<6 {
            let nh = now.0 + dh[i]
            let ny = now.1 + dy[i]
            let nx = now.2 + dx[i]
            
            if nh < 0 || nh >= h || ny < 0 || ny >= y || nx < 0 || nx >= x {
                continue
            }
            if box[nh][ny][nx] == 0 {
                box[nh][ny][nx] = 1
                zeros -= 1
                queue.append((nh, ny, nx, now.3 + 1))
            }
        }
    }
    return last
}

let result = solution()

if zeros != 0 {
    print(-1)
}
else {
    print(result)
}


