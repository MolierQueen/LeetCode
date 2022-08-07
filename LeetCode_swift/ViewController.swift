//
//  ViewController.swift
//  LeetCode_swift
//
//  Created by 柴犬的Mini on 2022/7/30.
//

import UIKit

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(val: Int) { self.val = val; self.next = nil; }
    public init(val: Int, next: ListNode?) { self.val = val; self.next = next; }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 第一题
        print("twoSum =",self.twoSum([3,2,4], 6))
        
        
        // 第二题
        let l13 = ListNode(val: 3)
        let l12 = ListNode(val: 4, next: l13)
        let l11 = ListNode(val: 2, next: l12)
        
        let l23 = ListNode(val: 4)
        let l22 = ListNode(val: 6, next: l23)
        let l21 = ListNode(val: 5, next: l22)
        print("addTwoNumbers =",self.addTwoNumbers(l12,l21))

       
    }

    
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
//        for i in 0...nums.count - 1 {
//            for j in i + 1 ... nums.count - 1 {
//                if ((nums[i] + nums[j]) == target) {
//                    return [i,j]
//                }
//            }
//        }
//        return []
        
        
        var dict = [Int: Int]()
        for (i, num) in nums.enumerated() {
            if let lastIndex = dict[target - num] {
                return [lastIndex, i]
            }
            dict[num] = i
        }
        fatalError("No valid outputs")
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
//        输入：l1 = [2,4,3], l2 = [5,6,4]
//        输出：[7,0,8]
//        解释：342 + 465 = 807.
        
        
        var l111 = l1
        var l222 = l2
        var count:Double = 0.1
        while l111 != nil || l222 != nil {
            print(l111?.val ?? 0, l222!.val)
            if l111 != nil {
                l111 = l111?.next
            }
            
            if l222 != nil {
                l222 = l222?.next
            }
            count = count*10
        }
        print(1)
        
        
        
        
//        var l11 = l1
//        var count1 = 1
//        var arr1:[Int] = []
//        while l11 != nil  {
//            arr1.insert(l11!.val, at: 0)
//            l11 = l11!.next
//            count1 = count1 * 10
//        }
//        count1 = count1 / 10
//
//        var l22 = l2
//        var count2 = 1
//        var arr2:[Int] = []
//        while l22 != nil {
//            arr2.insert(l22!.val, at: 0)
//            l22 = l22!.next
//            count2 = count2 * 10
//        }
//        count2 = count2 / 10
//
//        var number1 = 0
//        for (i,number) in arr1.enumerated() {
//            if i>0 {
//                number1 = number1 + count1/(i*10) * number
//            } else {
//                number1 = number1 + count1*number
//            }
//        }
        
//        print(count2)
        
        return l1
    }

}

func getNext(l1: ListNode?) -> ListNode? {
    return l1?.next
}
