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
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 第一题
        print("twoSum =",self.twoSum([3,2,4], 6))
        
        
        // 第二题
        let l13 = ListNode(3)
        let l12 = ListNode(4, l13)
        let l11 = ListNode(2, l12)
        
        let l23 = ListNode(4)
        let l22 = ListNode(6, l23)
        let l21 = ListNode(5, l22)
        
        let ret = self.addTwoNumbers(l11,l21)
        print("addTwoNumbers =",ret!)

       
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
        
        var list1 = l1
        var list2 = l2
        var sum = 0
        let finalResult = ListNode(0)
        var moveNode = finalResult
        while list1 != nil || list2 != nil {
            if list1 != nil {
                sum += list1!.val
                list1 = list1!.next
            }
            
            if list2 != nil {
                sum += list2!.val
                list2 = list2!.next
            }
            
            moveNode.next = ListNode(sum % 10)
            moveNode = moveNode.next!
            sum /= 10
        }
        
        if sum > 0 {
            moveNode.next = ListNode(sum/10)
            moveNode.next?.next = nil
        }
        
        return finalResult.next
        
        
        /*********************首次编码************************/
//        /******学习（此题是基于以下原理）*****/
//        //        a 保存链表，用b去遍历 保存到a中
//        var a  = ListNode(1)
//        var b = a
//
////        同一个内存地址要加都加 所以b.next 就是a.next
//        b.next = ListNode(2)
//
////        把b指向 b的next 其实也就是a的next
//        b = b.next!
//
////        同一个内存地址下.next赋值都是同时赋值 所以a.next.next也一起被赋值
//        b.next = ListNode(3)
//        print(a,b)
//        /*****************************************/
//
//        var l11 = l1
//        var l22 = l2
////        这里比较巧妙，直接吧进位值加到sum中一起计算，不用单独变量
//        var sum:Int = 0
//        let result:ListNode =  ListNode()
//        var current = result
//        while l11 != nil || l22 != nil {
//            if l11 != nil {
//                sum = sum + l11!.val
//                l11 = l11?.next
//            }
//            if l22 != nil {
//                sum = sum + l22!.val
//                l22 = l22?.next
//            }
//            current.next = ListNode(sum % 10)
//            sum /= 10
//            current = current.next!
//        }
//
//        //        最后要记得可能有进位
//        if sum > 0 {
//            current.next = ListNode(sum % 10)
//        }
//        return result.next
    }
}
