//
//  LRUObj.swift
//  LeetCode_swift
//
//  Created by Molier on 2022/9/26.
//

import Foundation

class DoubleList:NSObject {
    var key:Int
    var value:Int
    var per:DoubleList?
    var next:DoubleList?
    
    override init() {
        key = 0
        value = 0
    }
    
    init(key:Int, value:Int, per: DoubleList? = nil, next: DoubleList? = nil) {
        self.key = key
        self.value = value
        self.per = per
        self.next = next
    }
}

class LRUObj: NSObject {
    
    var cacheDic:[Int:DoubleList]
    var maxLength = 0
    var listHead = DoubleList.init()
    var listLast = DoubleList.init()
    init(_ capacity: Int)  {
        self.cacheDic = [Int:DoubleList]()
        self.maxLength = capacity
        self.listHead.next = listLast
        listLast.per = self.listHead
    }
    
    func get(_ key: Int) -> Int {
        let realValue = self.cacheDic[key]
        if realValue != nil {
            self.deleteNode(needDelete: realValue!)
            self.insertNode(needInsert: realValue!)
            return realValue!.value
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) -> Void {
        let lastValue = self.cacheDic[key]
        if lastValue != nil {
            self.deleteNode(needDelete: lastValue!)
            let realValue = DoubleList.init(key: key, value: value)
            self.insertNode(needInsert: realValue)
            self.cacheDic[key] = realValue
            return
        }
        if self.cacheDic.keys.count >= self.maxLength  {
            let needRemoveValue = self.listLast.per
            self.deleteNode(needDelete: needRemoveValue!)
            self.cacheDic.removeValue(forKey: needRemoveValue!.key )
        }
        let realValue = DoubleList.init(key: key, value: value)
        self.insertNode(needInsert: realValue)
        self.cacheDic[key] = realValue
    }
    
    func deleteNode(needDelete:DoubleList) -> Void {
        let per = needDelete.per
        let next = needDelete.next
        per!.next = next
        next!.per = per
    }
    
    func insertNode(needInsert:DoubleList) -> Void {
        let currentHead = self.listHead.next
        self.listHead.next = needInsert
        needInsert.per = self.listHead
        needInsert.next = currentHead
        currentHead!.per = needInsert
    }
}

