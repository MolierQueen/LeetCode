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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    datasource
    var dataSource:Array = ["twoSum_1",
                            "addTwoNumbers_2",
                            "reverseList_206",
                            "lengthOfLongestSubstring_3",
                            "longestPalindrome_5",
                            "deleteMiddle_2095",
                            "findMedianSortedArrays_4"];
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = self.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let title = self.dataSource[indexPath.row]
        let method:Selector = NSSelectorFromString(title)
        if self.responds(to: method) {
            self.perform(method)
        }
    }
    
    //        链表
    let l13 = ListNode(3)
    let l12 = ListNode(4)
    let l11 = ListNode(2)
    
    let l23 = ListNode(4)
    let l22 = ListNode(6)
    let l21 = ListNode(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.l11.next = self.l12
        self.l12.next = self.l13
        
        self.l21.next = self.l22
        self.l22.next = self.l23
        
        //        创建tableview
        let mainTable = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(mainTable)
    }
    
    
    
    @objc func twoSum_1() {
        print("第1题twoSum =",self.twoSum([3,2,4], 6))
    }

    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        
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
    
    
    
    @objc func addTwoNumbers_2() {
        // 第2题
        print("第2题addTwoNumbers =\(self.addTwoNumbers(l11,l21)!)")
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
    
    @objc func reverseList_206() {
        // 第206题
        print("第206题reverseList = \(self.reverseList(l11)!)")
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
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
    
    @objc func lengthOfLongestSubstring_3() {
        // 第3题
        print("第3题 lengthOfLongestSubstring =",self.lengthOfLongestSubstring("aab"))
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        var dic:[Character:Int] = [Character:Int]()
        var start = 0
        var result = 0
        for (index, cha) in s.enumerated() {
            let last = dic[cha] ?? -1
            if  last >= start {
                start = last + 1
            }
            result = max(result, index - start + 1)
            dic[cha] = index
        }
        return result
        
        
        
    
        /****************第一次*********************/
        //        题解说是动态规划，但是没有太听懂，不过代码明白
        
//        还是用字典 空间换时间
//        var dic = [Character: Int]()
//        var start = 0
//        var result = 0
//        for (index, char) in s.enumerated() {
//
//            //            找到之前存在过的字母的下标，没找到就是-1
//            let previousIndex = dic[char] ?? -1
//
//            //            如果之前的下标大于star，说明找到了了重复的，
//            if previousIndex >= start {
//                //                那么滑动窗口的起始位置就从之前找到重复的下一个进行
//                start = previousIndex + 1
//            }
//
//            //            当前的长度就是，当前坐标减去其实坐标+1
//            let currentLength = index - start + 1
//
//            //            记录最长的长度
//            result = max(result, currentLength)
//
//            //            给字典赋值 Key 是字母   value是下标 注意你要找谁就用谁当Key
//            dic[char] = index
//        }
//        return result
    }
                
    
    @objc func longestPalindrome_5() {
        print("第5题 longestPalindrome =",self.longestPalindrome("aaba"))
    }
    
    //    第五题最长回文字符串
    func longestPalindrome(_ s: String) -> String {
        /************第二次提交，自己复习******************/

        let stringArr:[String] = s.map({String($0)})
        if stringArr.count <= 0 {
            return ""
        }
        
        if stringArr.count < 2 {
            return s
        }
        
        var length = 0
        var star = 0
        var end = 0
        for i in 0 ..< stringArr.count {
//            从中心扩散法，找到中心的那个\2个字符，然后往两边匀速扩散，
            length = max(self.findHuiWen(stringArr: stringArr, leftIndex: i, rightIndex: i), self.findHuiWen(stringArr: stringArr, leftIndex: i, rightIndex: i+1))
            
//            如果结果比上一次的要长，就更新start和end
            if(length > end - star) {
//                算起止下标的，仔细想想就明白了
                if length % 2 > 0 {
                    star = i - length/2
                } else {
                    star = i + 1 - length/2
                }
                end = i + length/2
            }
        }
        
        //        拿到起止下标 最后再分割字符串
        return stringArr.dropFirst(star).prefix(end-star+1).joined()

        /************第一次提交，记录下超过百分百用户✌🏻******************/
//        if s.count < 2 {
//            return s
//        }
//        var start = 0
//        var end = 0
//        var array = s.map({ String.init($0)})
//        for i in 0 ..< s.count {
//            let len1 = expandCenter(array: array, left: i, right: i)
//            let len2 = expandCenter(array: array, left: i, right: i + 1)
//            let len = max(len1, len2)
//            if(len > end - start) {
//
//                if len % 2 > 0 {
//                    start = i - len/2
//                } else {
//                    start = i + 1 - len/2
//                }
////                start = i - (len - 1) / 2
//                end = i + len / 2
//
//            }
//        }
//        array.removeFirst(start)
//        let sub = array.prefix(end - start + 1).joined()
//        return sub
    }
    
    func expandCenter(stringArr: [String], leftIndex: Int, rightIndex: Int) -> Int {
        var l = leftIndex
        var r = rightIndex
        while l >= 0 && r < stringArr.count && stringArr[l] == stringArr[r] {
            l -= 1
            r += 1
        }
        return r - l - 1
    }
    
    func findHuiWen(stringArr:[String], leftIndex:Int, rightIndex:Int) -> Int {
        var left = leftIndex
        var right = rightIndex
        while left > 0 && right < stringArr.count && stringArr[left] == stringArr[right] {
            //            开始往两边扩散，条件为两边到头，或者两边值不相等
            left = left - 1
            right = right + 1
        }
        return right - left - 1
    }
    
    // 冒泡排序 自己练习
    func paix(arr:[Int]) -> [Int] {
        var arr1 = arr
        for i in 0 ..< arr1.count {
            for j in 0 ..< arr1.count - i - 1 {
                if arr1[j] > arr1[j+1] {
                    let tmp = arr1[j+1]
                    arr1[j+1] = arr1[j]
                    arr1[j] = tmp
                }
            }
        }
        return arr1
    }
    
    // 第2095题删除链表中间节点
    @objc func deleteMiddle_2095() {
        //        2 4 3
        let head = self.deleteMiddle(self.l11)
        print("第2095题 deleteMiddle = \(head)")
    }

    func deleteMiddle(_ head: ListNode?) -> ListNode? {
//        由于链表不支持随机访问，因此常见的找出链表中间节点的方法是使用快慢指针：即我们使用两个指针 \textit{fast}fast 和 \textit{slow}slow 对链表进行遍历，其中快指针 \textit{fast}fast 每次遍历两个元素，慢指针 \textit{slow}slow 每次遍历一个元素。这样在快指针遍历完链表时，慢指针就恰好在链表的中间位置。
        if head == nil || head?.next == nil{
            return nil
        }
        var fast = head
//        之所以slow要是哑结点，是因为我要删除中间节点，slow必须要停留在中间节点的上一个节点才能执行 slow?.next = slow?.next?.next 进行删除，所以slow先指向前一个节点，慢个一拍
        var slow:ListNode = ListNode.init()
        slow.next = head
        let res = slow
        while fast?.next != nil {
            slow = slow.next!
            fast = fast?.next?.next
        }
        slow.next = slow.next?.next
        return res.next
        
        
        
        /************第一次提交，暴力解法，还可以******************/

//        if head == nil {
//            return nil
//        }
//        if head?.next == nil {
//            return nil
//        }
//        var count:Int = 0
//        var count1:Int = 0
//        var current = head
//        var current1 = head
//        let current2 = current1
//        while current != nil {
//            count = count+1
//            current = current!.next
//        }
//
//        count = count/2
//
//        while current1 != nil {
//            count1 = count1+1
//            if count1 == count {
//                current1?.next = current1?.next?.next
//                break
//            }
//            current1 = current1?.next
//        }
//        return current2
    }
    
    //    第四题. 寻找两个正序数组的中位数
   @objc func findMedianSortedArrays_4() -> Void {
        let arr1:[Int] = [1,2]
        let arr2:[Int] = [3,4]
        print("中位数为 = \(self.findMedianSortedArrays(arr1, arr2))")
    }
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        /************第一次提交，暴力解法，冒泡一次过******************/
        let totalCount = nums2.count + nums1.count
        var centerNum = 0
        if totalCount < 2 {
            if let fir = nums1.first {
                return Double(fir)
            } else {
                return Double(nums2.first!)
            }
        }
        
        var totalArr:[Int] = [Int]()
        for num in nums1 {
            totalArr.append(num)
        }
        for num in nums2 {
            totalArr.append(num)
        }
        
        var isOK:Bool = true
        for i in 0 ..< totalArr.count {
            for j in 0 ..< totalArr.count - i-1 {
                if totalArr[j] > totalArr[j+1] {
                    isOK = false
                    let tmp = totalArr[j+1]
                    totalArr[j+1] = totalArr[j]
                    totalArr[j] = tmp
                }
            }
            if isOK {
                break
            }
        }
        
        if (totalCount % 2) == 0 {
            centerNum = totalCount/2 - 1
            return (Double(totalArr[centerNum])+Double(totalArr[centerNum+1]))/2.0
        }
        centerNum = totalCount/2
        return Double(totalArr[centerNum])
    }
}
