//
//  LRUObj.swift
//  LeetCode_swift
//
//  Created by Molier on 2022/9/26.
//

import Foundation
class LRUObj: NSObject {
    
    var cacheDic:[Int:Int]
    var keyArr:[Int]
    var maxLength = 0
    init(_ capacity: Int)  {
        self.cacheDic = [Int:Int]()
        self.keyArr = [Int]()
        self.maxLength = capacity
    }
    
    func get(_ key: Int) -> Int {
        if self.cacheDic[key] != nil {
            self.keyArr.append(key)
            for (index ,tmpKey) in self.keyArr.enumerated() {
                if key == tmpKey {
                    self.keyArr.remove(at: index)
                    break
                }
            }
            return self.cacheDic[key]!
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) -> Void {
        if self.cacheDic[key] != nil {
            self.cacheDic[key] = value
            for (index ,tmpKey) in self.keyArr.enumerated() {
                if key == tmpKey {
                    self.keyArr.remove(at: index)
                    break
                }
            }
            self.keyArr.append(key)
            return
        }
        if self.cacheDic.keys.count >= self.maxLength  {
            let realKey = self.keyArr[0]
            self.cacheDic.removeValue(forKey: realKey)
            self.keyArr.remove(at: 0)
        }
        self.cacheDic[key] = value
        self.keyArr.append(key)
    }
}

