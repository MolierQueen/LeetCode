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
        
        //        链表
        let l13 = ListNode(3)
        let l12 = ListNode(4, l13)
        let l11 = ListNode(2, l12)
        
        let l23 = ListNode(4)
        let l22 = ListNode(6, l23)
        let l21 = ListNode(5, l22)
        
        // 第1题
        print("第1题twoSum =",self.twoSum_1([3,2,4], 6))
        
        
        // 第2题
        print("第2题addTwoNumbers =\(self.addTwoNumbers_2(l11,l21)!)")
        
        
        // 第206题
        print("第206题reverseList = ", self.reverseList_206(l11)!)
        
        
        // 第3题
        print("第3题 lengthOfLongestSubstring =",self.lengthOfLongestSubstring_3("aab"))
        
    }

    
    func twoSum_1(_ nums: [Int], _ target: Int) -> [Int] {
        
        
        var dic:[Int:Int] = [:]
        for (index, number) in nums.enumerated() {
            if let cha = dic[target - number] {
                return [cha, index]
            }
            dic[number] = index
        }
        fatalError("No valid outputs")

        
        
//        for i in 0...nums.count - 1 {
//            for j in i + 1 ... nums.count - 1 {
//                if ((nums[i] + nums[j]) == target) {
//                    return [i,j]
//                }
//            }
//        }
//        return []
        
        
//        var dict = [Int: Int]()
//        for (i, num) in nums.enumerated() {
//            if let lastIndex = dict[target - num] {
//                return [lastIndex, i]
//            }
//            dict[num] = i
//        }
//        fatalError("No valid outputs")
    }
    
    
    
    func addTwoNumbers_2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
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
    
    func reverseList_206(_ head: ListNode?) -> ListNode? {
        //        2 4 3
        
//        if head == nil {
//            return nil
//        }
//
//        if head?.next == nil {
//            return head
//        }
//
//        var ret = self.reverseList_206(head?.next)
//
//        head?.next?.next = head
//        head?.next = nil
//        return ret
        
        var cur = head
        var pre:ListNode?
        
        while cur != nil {
            let next = cur!.next
            
            cur!.next = pre
            pre = cur!
            cur = next
        }
        
        return pre
        

//        翻转 A->B->C->D->nil
//        第一步：A->B->C<-D
//        第二步：A->B<-C<-D
//        第三步：nil<-A<-B<-C<-D
//        所以先找到最后一个节点，然后从后往前走

        
//        //        结束条件、下一个节点为空（最后一个节点）
//        guard let currentNode = head, let _ = head?.next else {return head}
//
//        //        一层层递归找到最后一个节点
//        let newList = self.reverseList_206(currentNode.next)
//
//        //        A -> B   变成   B -> A
//        currentNode.next?.next = currentNode
//        //        B -> A  变成   B -> A -> nil
//        currentNode.next = nil
//
////        永远返回最后一个节点，因为翻转后最后一个节点就是头节点，
////        所以最后返回的就是反转后的链表
//        return newList
        
        
        /****************第二次*********************/
//        //        迭代方法2
//        //        创建一个变量保存前置节点
//        var prev: ListNode?
//
//        //        创建一个移动指针往下走
//           var curr: ListNode? = head
//
//        //        开始遍历
//           while curr != nil {
//
//               //               先把之后的节点保存下，方便后面往下移动
//               let next: ListNode? = curr?.next
//
////               把前置节点给到当前节点的下一个，
////               换句话说就是把当前节点插到上一个节点的前面
//               curr?.next = prev
//
////               保存上一个节点
//               prev = curr
//
////               往下移动
//               curr = next
//           }
//
//
//
//           return prev
        
        /****************第一次*********************/
//        var list = head
//        var arr:[ListNode] = Array()
//        while list != nil {
//            let tmpNode:ListNode = ListNode(list!.val)
//            arr.append(tmpNode)
//            list = list!.next
//        }
//
//        let result:ListNode = ListNode(0)
//        var moveNode = result
//
//        for node in arr.reversed() {
//            print(node.val)
//            moveNode.next = node
//            if let tmpNode = moveNode.next {
//                //往下走
//                moveNode = tmpNode
//            } else {
//                moveNode.next = nil
//            }
//        }
//        return result.next
    }
    
    
    func lengthOfLongestSubstring_3(_ s: String) -> Int {
    
        /****************第一次*********************/
        //        题解说是动态规划，但是没有太听懂，不过代码明白
        
//        还是用字典 空间换时间
        var dic = [Character: Int]()
        var start = 0
        var result = 0
        for (index, char) in s.enumerated() {
            
            //            找到之前存在过的字母的下标，没找到就是-1
            let previousIndex = dic[char] ?? -1
            
            //            如果之前的下标大于star，说明找到了了重复的，
            if previousIndex >= start {
                //                那么滑动窗口的起始位置就从之前找到重复的下一个进行
                start = previousIndex + 1
            }
            
            //            当前的长度就是，当前坐标减去其实坐标+1
            let currentLength = index - start + 1
            
            //            记录最长的长度
            result = max(result, currentLength)
            
            //            给字典赋值 Key 是字母   value是下标 注意你要找谁就用谁当Key
            dic[char] = index
        }
        return result
    }
    
}
