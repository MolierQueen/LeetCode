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
                            "findMedianSortedArrays_4",
                            "bubbleSort_me",
                            "InsertionSort_me",
                            "MergeSort_me",
                            "Quicksort_me",
                            "CountingSort_me",
                            "BinarySearch_me",
                            "merge_88",
                            "collectionRain_42",
                            "numIslands_200",
                            "maxProfit_121",
                            "LRUCache_146",
                            "copyRandomList_138",
                            "spiralOrder_54",
                            "mergeTwoLists_21",
                            "reverseWords_151",
                            "myAtoi_8",
                            "firstMissingPositive_41",
                            "threeSum_15",
                            "goodNodes_1448",
                            "topKFrequent_347",
                            "rightSideView_199",
                            "ImplementQueueWithStack_232",
                            "rob_198",
                            "mySqrt_69",
                            "sumZero_1304",
                            "arraySign_1822",
                            "findKthLargest_215",
                            "maxNumberOfFamilies_1386"];
    
    
    
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
    
    func showAlert(title:String, message:String) -> Void {
        let alert:UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertOK:UIAlertAction = UIAlertAction.init(title: "知道了", style: UIAlertAction.Style.destructive)
        alert.addAction(alertOK)
        self.present(alert, animated: true)
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
        mainTable.scrollToRow(at: IndexPath(row: self.dataSource.count - 1, section: 0), at: UITableView.ScrollPosition.top, animated: true)
        self.view.addSubview(mainTable)
    }
    
    
    
    @objc func twoSum_1() {
        self.showAlert(title: "第1题twoSum", message: self.twoSum([3,2,4], 6).debugDescription)
        print("第1题twoSum =",self.twoSum([3,2,4], 6))
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        //        休想在这道题使用双指针，双指针用在有序数组上的
        
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
        self.showAlert(title: "第2题addTwoNumbers", message: self.addTwoNumbers(l11,l21).debugDescription)
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
        self.showAlert(title: "第206题reverseList", message: self.reverseList(l11).debugDescription)
        print("第206题reverseList = \(self.reverseList(l11)!)")
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        //        2 -> 4 -> 3
        //        var perNode:ListNode?
        //        var currentNode = head
        //
        //        while currentNode != nil {
        //            let nextNode = currentNode?.next
        //            currentNode!.next = perNode
        //            perNode = currentNode!
        //            currentNode = nextNode
        //        }
        //
        //        return perNode
        
        
        var curren = head
        if curren?.next == nil {
            return curren
        }
        let node = self.reverseList(curren?.next)
        curren?.next?.next = curren
        curren?.next = nil
        return node
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
        
        //        var cur = head
        //        var pre:ListNode?
        //
        //        while cur != nil {
        //            let next = cur!.next
        //
        //            cur!.next = pre
        //            pre = cur!
        //            cur = next
        //        }
        //
        //        return pre
        
        
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
        self.showAlert(title: "第3题 lengthOfLongestSubstring", message: String(self.lengthOfLongestSubstring("aab")))
        print("第3题 lengthOfLongestSubstring =",self.lengthOfLongestSubstring("aab"))
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        
        var dic:[Character:Int] = Dictionary()
        var star = 0
        var length = 0
        for (index, string) in s.enumerated() {
            var lastIndex = dic[string] ?? -1
            if lastIndex >= star {
                star = lastIndex + 1
            }
            dic[string] = index
            length = max(length, index - star + 1)
        }
        return length
        
        
        
        //        var dic:[Character:Int] = [Character:Int]()
        //        var start = 0
        //        var result = 0
        //        for (index, cha) in s.enumerated() {
        //            let last = dic[cha] ?? -1
        //            if  last >= start {
        //                start = last + 1
        //            }
        //            result = max(result, index - start + 1)
        //            dic[cha] = index
        //        }
        //        return result
        
        
        
        
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
        self.showAlert(title: "第5题 longestPalindrome", message: self.longestPalindrome("aaba").debugDescription)
        print("第5题 longestPalindrome =",self.longestPalindrome("aaba"))
    }
    
    func huiwen(s:[String], left: Int, right: Int) -> Int {
        var rightIndex = right
        var leftIndex = left
        
        while leftIndex >= 0 && rightIndex < s.count  && s[leftIndex] == s[rightIndex] {
            rightIndex += 1
            leftIndex -= 1
        }
        
        return rightIndex - leftIndex - 1
    }
    
    //    第五题最长回文字符串
    func longestPalindrome(_ s: String) -> String {
        
        var strArr = s.map({String($0)})
        var start = 0
        var end = 0
        var maxLength = 0
        for i in 0 ..< strArr.count {
            var  length = max(self.huiwen(s: strArr, left: i, right: i), self.huiwen(s: strArr, left: i, right: i + 1))
            
            if maxLength < length {
                maxLength = length
                if length % 2 == 0 {
                    start = i + 1 - length / 2
                } else {
                    start = i  - length / 2
                }
                end = length / 2 + i
            }
            
            
        }
        return strArr.dropFirst(start).prefix(end - start + 1).joined()
        
        
        
        
        
        
        
        
        /************第二次提交，自己复习******************/
        
        //        let stringArr:[String] = s.map({String($0)})
        //        if stringArr.count <= 0 {
        //            return ""
        //        }
        //
        //        if stringArr.count < 2 {
        //            return s
        //        }
        //
        //        var length = 0
        //        var star = 0
        //        var end = 0
        //        for i in 0 ..< stringArr.count {
        ////            从中心扩散法，找到中心的那个\2个字符，然后往两边匀速扩散，
        //            length = max(self.findHuiWen(stringArr: stringArr, leftIndex: i, rightIndex: i), self.findHuiWen(stringArr: stringArr, leftIndex: i, rightIndex: i+1))
        //
        ////            如果结果比上一次的要长，就更新start和end
        //            if(length > end - star) {
        ////                算起止下标的，仔细想想就明白了
        //                if length % 2 > 0 {
        //                    star = i - length/2
        //                } else {
        //                    star = i + 1 - length/2
        //                }
        //                end = i + length/2
        //            }
        //        }
        //
        //        //        拿到起止下标 最后再分割字符串
        //        return stringArr.dropFirst(star).prefix(end-star+1).joined()
        
        /************第一次提交，记录下超过百分百用户✌🏻******************/
        //        if s.count < 2 {
        //            return s
        //        }
        //        var start = 0
        //        var end = 0
        //        var array = s.map({ String.init($0)})
        //        for i in 0 ..< s.count {
        //            let len1 = expandCenter(stringArr: array, leftIndex: i, rightIndex: i)
        //            let len2 = expandCenter(stringArr: array, leftIndex: i, rightIndex: i + 1)
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
        
        //        结束后 r 与 之间的字符长度就是回文的长度，但是要注意，因为已经扩散了（ l -= 1 和  r += 1 所以 不包括l 和 r   就是  j - i + 1 - 2）
        return r - l - 1
    }
    
    func findHuiWen(stringArr:[String], leftIndex:Int, rightIndex:Int) -> Int {
        var left = leftIndex
        var right = rightIndex
        while left >= 0 && right < stringArr.count && stringArr[left] == stringArr[right] {
            //            开始往两边扩散，条件为两边到头，或者两边值不相等
            left = left - 1
            right = right + 1
        }
        return right - left - 1
    }
    
    // 第2095题删除链表中间节点
    @objc func deleteMiddle_2095() {
        //        2 4 3
        let head = self.deleteMiddle(self.l11)
        self.showAlert(title: "第2095题 deleteMiddle", message: head.debugDescription)
        print("第2095题 deleteMiddle = \(String(describing: head))")
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
        self.showAlert(title: "第4题findMedianSortedArrays", message: self.findMedianSortedArrays(arr1, arr2).debugDescription)
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
    
    //冒泡排序
    @objc func bubbleSort_me() ->(){
        //        需要遍历i （数组个数）次，每一次遍历都会将自己与自己下一个数进行比较根据题意来进行是否交换（正序，逆序），当一次遍历完成后（j < arr.count-i-1 因为遍历过后就已经有序，所以便利了i次就是已经有倒数i个数字是有序的，减一是因为不包含自己），最后的那个数已经到了他自己该在的位置上。
        var arr:Array = [3, 5, 2, 9, 4, 10, 7, 8 ,1]
        for i in 0 ..< arr.count {
            for j in 0 ..< arr.count - i - 1 {
                if arr[j] > arr[j+1] {
                    let tmp = arr[j]
                    arr[j] = arr[j+1]
                    arr[j+1] = tmp
                }
            }
        }
        
        self.showAlert(title: "bubbleSort_me", message: String(describing: arr))
    }
    
    //    插入排序
    @objc func InsertionSort_me() ->(){
        var arr:Array = [3, 1, 2, 9, 4, 10, 7, 8 ,12]
        
        if arr.count <= 1 {
            return
        }
        
        for i in 0 ..< arr.count {
            let current = arr[i]
            
            var index = 0
            while index < i && arr[index] <= current {
                index += 1
            }
            arr.swapAt(i, index)
            
            
            //            var index = i - 1
            //            while index >= 0 && current < arr[index] {
            //                arr[index + 1] = arr[index]
            //                index -= 1
            //            }
            //            arr[index+1] = current
        }
        
        self.showAlert(title: "InsertionSort_me", message: String(describing: arr))
    }
    
    func feibo(num:Int) -> Int{
        //        斐波那契遍历
        var a = 1
        var b = 1
        var c = 0
        for _ in 0..<num {
            a = b
            b = c
            c = a + b
        }
        
        return c
        
        //   斐波那契递归
        if num==1||num==2 {
            return 1
        }
        return self.feibo(num: num-1)+self.feibo(num: num-2)
    }
    
    //    归并排序
    @objc func MergeSort_me() ->(){
        var arr:Array = [3, 1, 2, 9, 4, 10, 7, 8 ,12]
        if arr.count <= 1 {
            return
        }
        self.processing(arr: &arr, left: 0, right: arr.count-1)
        self.showAlert(title: "MergeSort_me", message: String(describing: arr))
    }
    
    func processing(arr:inout [Int], left:Int , right:Int) -> Void {
        if left == right {return}
        let middle = left + (right - left) / 2
        self.processing(arr: &arr, left: left, right: middle)
        self.processing(arr: &arr, left: middle + 1, right: right)
        self.mergeArr(arr: &arr, left: left, middle: middle, right: right)
    }
    
    func mergeArr(arr:inout [Int], left:Int, middle:Int, right:Int) -> Void {
        var leftPoint:Int = left
        var rightPoint:Int = middle + 1
        var tmpArr:[Int] = [Int]()
        while leftPoint <= middle && rightPoint <= right {
            if arr[leftPoint] > arr[rightPoint] {
                tmpArr.append(arr[rightPoint])
                rightPoint += 1
            } else {
                tmpArr.append(arr[leftPoint])
                leftPoint += 1
            }
        }
        
        //        while leftPoint <= middle {
        //            tmpArr.append(arr[leftPoint])
        //            leftPoint += 1
        //        }
        //
        //        while rightPoint <= right {
        //            tmpArr.append(arr[rightPoint])
        //            rightPoint += 1
        //        }
        //
        if leftPoint >= middle {
            for i in rightPoint ..< (right+1) {
                tmpArr.append(arr[i])
            }
        }
        if rightPoint >= right {
            for i in leftPoint ..< (middle+1) {
                tmpArr.append(arr[i])
            }
        }
        
        for (index, num) in tmpArr.enumerated() {
            let realIndex = index + left
            arr[realIndex] = num
        }
        
        
    }
    
    // 快速排序
    @objc func Quicksort_me() ->(){
        var arr:Array = [3, 1, 2, 9, 4, 10, 7, 8 ,12, 6]
        if arr.count <= 1 {
            return
        }
        self.quickSort(arr: &arr, left: 0, right: arr.count - 1)
        self.showAlert(title: "Quicksort_me", message: String(describing: arr))
    }
    
    func quickSort(arr:inout [Int], left:Int, right:Int) -> Void {
        if left >= right{return}
        let standard = self.findStandardIndex(arr: &arr, left: left, right: right)
        self.quickSort(arr: &arr, left: left, right: standard - 1)
        self.quickSort(arr: &arr, left: standard + 1, right: right)
    }
    
    func findStandardIndex(arr: inout [Int], left:Int, right:Int) -> Int {
        var tmpEle = arr[right]
        var start = left
        for i in left ..< right {
            if arr[i] <= tmpEle {
                arr.swapAt(i, start)
                //                var tmp:Int
                //                tmp = arr[i]
                //                arr[i] = arr[start]
                //                arr[start] = tmp
                start += 1
            }
        }
        
        arr.swapAt(start, right)
        
        //        var tmp1:Int = 0
        //        tmp1 = arr[right]
        //        arr[right] = arr[start]
        //        arr[start] = tmp1
        
        return start
    }
    
    // 计数排序   https://blog.csdn.net/weixin_48992199/article/details/108055666
    @objc func CountingSort_me() ->(){
        let arr:Array = [3,5,1,3,2,5,4,1,3,2]
        var max = 0
        for i in 0 ..< arr.count {
            if arr[i] >= max {
                max = arr[i]
            }
        }
        var tmpArr:[Int] = [Int]()
        for _ in 0 ..< max+1 {
            tmpArr.append(0)
        }
        
        for num in arr {
            tmpArr[num] += 1
        }
        
        //        这样也可以 显得牛逼
        //        for i in 0 ..< arr.count {
        //            tmpArr[arr[i]] += 1
        //        }
        
        // 把数组加累加
        for i in 1 ..< tmpArr.count {
            tmpArr[i] += tmpArr[i - 1]
        }
        
        var resultArr:[Int] = [Int]()
        for _ in 0 ..< arr.count {
            resultArr.append(0)
        }
        
        for num in arr {
            let index = tmpArr[num] - 1
            //            不需要判断大于0  能取到一定是有值的
            //            if index >= 0 {
            resultArr[index] = num
            tmpArr[num] -= 1
            //            }
        }
        
        //        for i in 0 ..< arr.count {
        //            var index = tmpArr[arr[i]] - 1
        //            if index >= 0 {
        //                resultArr[index] = arr[i]
        //                tmpArr[arr[i]] -= 1
        //            }
        //        }
        
        
        
        //        for i in 0 ..< tmpArr.count {
        //            let times = tmpArr[i]
        //            if times > 0 {
        //                for _ in 0 ..< times {
        //                    resultArr.append(i)
        //                }
        //            }
        //        }
        self.showAlert(title: "Quicksort_me", message: String(describing: resultArr))
    }
    
    // 二分查找
    @objc func BinarySearch_me() ->(){
        
        var arr:Array = [1,3,4,6,8,8,8,12,67,90]
        let target = 8
        
        let a = self.binary(arr: &arr, left: 0, right: arr.count-1, target:target)
        let b = self.binary1(arr: &arr, target:target)
        print(b)
        
        
    }
    
    // 递归二分查找
    func binary(arr:inout [Int], left:Int, right:Int, target:Int) -> Int {
        
        if left == right {
            if arr[left] == target {
                return left
            }
            print("没有")
            return -1
        }
        
        let middle = left + (right - left) / 2
        if arr[middle] == target {
            return left + (right - left) / 2
        }
        
        if arr[middle] >  target {
            return self.binary(arr: &arr, left: left, right:middle, target: target)
        } else {
            return self.binary(arr: &arr, left: middle + 1, right: right, target: target)
        }
    }
    
    // 遍历二分查找
    func binary1(arr:inout [Int], target:Int) -> Int {
        var start = 0
        var end = arr.count - 1
        while start <= end {
            let middle = start + ((end - start) >> 1)
            //            if arr[middle] == target {
            //                return middle
            //            }
            
            if arr[middle] > target {
                end = middle - 1
            } else if arr[middle] < target {
                start = middle + 1
            } else {
                if middle == arr.count - 1 || arr[middle + 1] != target {
                    return middle
                } else {
                    start = middle + 1
                }
            }
        }
        
        return -1
    }
    
    // 合并两个有序数组
    @objc func merge_88() -> () {
        
        var nums1:[Int] = [1,2,3,0,0,0]
        let m = 3
        let nums2 = [2,5,6]
        let n = 3
        self.merge(&nums1, m, nums2, n)
        self.showAlert(title: "merge_88", message: "\(nums1)")
    }
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        let total = m + n
        var index1 = 0
        var index2 = 0
        var tmpArr = [Int]()
        
        while index1 < m && index2 < n  {
            if nums1[index1] <= nums2[index2] {
                tmpArr.append(nums1[index1])
                index1 += 1
            } else {
                tmpArr.append(nums2[index2])
                index2 += 1
            }
        }
        if index1 >= m {
            while index2 < n {
                tmpArr.append(nums2[index2])
                index2 += 1
            }
        } else if index2 >= n {
            while index1 < m {
                tmpArr.append(nums1[index1])
                index1 += 1
            }
        }
        nums1 = tmpArr
        //
        //
        //
        //
        //
        //
        //
        ////        for i in 0 ..< total {
        ////            var num1
        ////            var num2
        ////            if i < nums1.count {
        ////                num1 = nums1[i]
        ////            }
        ////            if i < nums2.count {
        ////                num2 = nums2[i]
        ////            }
        ////
        ////
        ////            if num1<= num2 {
        ////                nums1[i] = num1
        ////            } else {
        ////                nums1[i] = num2
        ////            }
        ////        }
        //
        
    }
    
    //    接雨水
    @objc func collectionRain_42() -> () {
        let height = [0,1,0,2,1,0,1,3,2,1,2,1]
        let a = self.trap(height)
        self.showAlert(title: "collectionRain_42", message: "\(a)")
    }
    //
    //    func findeRain(arr:[Int], currentIndex: Int) -> Int {
    //        var res = 0
    //        if currentIndex >= arr.count { return  findeRain(arr: arr, currentIndex: currentIndex) }
    //
    //        return (res += findeRain(arr: arr, currentIndex: 1))
    //    }
    
    func trap(_ height: [Int]) -> Int {
        
        
        
        
        
        
        var index = 0
        var left = 0
        var right = 0
        var result = 0
        
        while index < height.count {
            var maxLeft = 0
            while left >= 0 {
                maxLeft = max(maxLeft, height[left])
                left -= 1
            }
            
            var maxRight = 0
            while right < height.count {
                maxRight = max(maxRight, height[right])
                right += 1
            }
            
            let short = min(maxRight, maxLeft)
            if short > height[index] {
                let number = (short - height[index])
                print("列为\(index)  雨水数为\(number)" )
                result += number
            }
            
            index += 1
            left = index
            right = index
        }
        return result
    }
    
    
    //    岛屿的数量
    @objc func numIslands_200() -> Void {
        
        //        let grid = [
        //          ["1","1","1","1","0"],
        //          ["1","1","0","1","0"],
        //          ["1","1","0","0","0"],
        //          ["0","0","0","0","0"]
        //        ]
        
        var grid = [
            ["1","1","0","0","0"],
            ["1","1","0","0","0"],
            ["0","0","1","0","0"],
            ["0","0","0","1","1"]
        ]
        //
        //        var grid = [
        //            ["1","0","1","1","0","1","1"]
        //        ]
        
        self.showAlert(title: "numIslands_200", message: "\(self.numIslands(grid))")
        
    }
    
    func numIslands(_ grid: [[String]]) -> Int {
        var landsCount = 0
        var grid1 = grid
        for i in 0 ..< grid1.count {
            let arr:[String] = grid1[i]
            for j in 0 ..<  arr.count  {
                let string = grid1[i][j]
                if string == "1" {
                    landsCount += 1
                    self.findIand(grid: &grid1, v: j, h: i)
                    print(grid1)
                }
            }
        }
        return landsCount
    }
    
    func findIand(grid: inout [[String]], v:Int, h:Int) -> Void {
        if v < 0 || v >= grid[0].count {
            return
        }
        
        if h < 0 || h >= grid.count {
            return
        }
        
        if grid[h][v] == "0" {
            return
        }
        
        grid[h][v] = "0"
        self.findIand(grid: &grid, v: v, h: h - 1)
        self.findIand(grid: &grid, v: v, h: h + 1)
        self.findIand(grid: &grid, v: v - 1, h: h)
        self.findIand(grid: &grid, v: v + 1, h: h)
    }
    
    
    //买卖股票
    @objc func maxProfit_121() -> Void {
        var arr = [7,1,5,3,6,4]
        self.showAlert(title: "maxProfit_121", message: "\(self.maxProfit(arr))")
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        
        //        思路在于循环遍历当前的股票价格， 收益为：用当前价格减去过去曾经的最小值即可
        //        然后在收益中取最大的
        if prices.count < 2 { return -1 }
        var minPri = prices[0]
        var res = 0
        for i in 0 ..< prices.count {
            minPri = min(minPri, prices[i])
            res = max(res, prices[i] - minPri)
        }
        return res
    }
    
    //实现一个LRU   字典+ 双向链表   Key 就是Key   value就是 链表节点
    @objc func LRUCache_146() -> Void {
        //        ["LRUCache","get","put","get","put","put","get","get"]
        //        [[2],[2],[2,6],[1],[1,5],[1,2],[1],[2]]
        let lRUCache = LRUObj(2)
        lRUCache.put(1, 1); // 缓存是 {1=1}
        lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
        lRUCache.get(1);    // 返回 1
        lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
        lRUCache.get(2);    // 返回 -1 (未找到)
        lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
        lRUCache.get(1);    // 返回 -1 (未找到)
        lRUCache.get(3);    // 返回 3
        lRUCache.get(4);    // 返回 4
        self.showAlert(title: "LRUCache_146", message: "最后一步为 \(lRUCache.get(4)) 不过还是看Log吧")
    }
    
    @objc func copyRandomList_138() -> Void {
        //        [[7,null],[13,0],[11,4],[10,2],[1,0]]
        let node1 = Node.init(7)
        let node2 = Node.init(13)
        let node3 = Node.init(11)
        let node4 = Node.init(10)
        let node5 = Node.init(1)
        node1.next = node2
        node3.random = nil
        node2.next = node3
        node2.random = node1
        node3.next = node4
        node3.random = node4
        node4.next = node5
        node4.random = node2
        node5.next = nil
        node5.random = node1
        self.showAlert(title: "copyRandomList_138", message: "\(self.copyRandomList(node1))")
    }
    
    public class Node {
        public var val: Int
        public var next: Node?
        public var random: Node?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
            self.random = nil
        }
    }
    
    func copyRandomList(_ head: Node?) -> Node? {
        if head == nil {
            return nil
        }
        var myHead = head
        // *********************用哈希表，用 哈希+ 节点回溯方法 ********
        
        //        注意  swift 没办法哈希   要写这个就要用 OC吧
        //         var dict = [UnsafeMutableRawPointer: Node]()
        //        head.toOpaque()
        //        var key = Unmanaged.passUnretained(head!).toOpaque()
        //         var cur = head
        //         while cur != nil {
        //             dict[cur!] = Node(cur!.val)
        //             cur = cur!.next
        //         }
        //         cur = head
        //         while cur != nil {
        //             dict[cur!]?.next = dict[cur!.next ?? Node(-1)]
        //             dict[cur!]?.random = dict[cur!.random ?? Node(-1)]
        //             cur = cur!.next
        //         }
        //         return dict[head!]
        
        
        // *********************不适用哈希表，直接用 迭代+ 节点拆分方法 ********
        //        思路为 先拼成A->A`->B->B`....
        while myHead != nil {
            var next = myHead!.next
            var tmpNode = Node(myHead!.val)
            myHead!.next = tmpNode
            tmpNode.next = next
            myHead = next
        }
        
        var myNewHead = head
        while myNewHead != nil {
            var next = myNewHead!.next?.next
            var myCopyNode = myNewHead!.next
            myCopyNode?.random = myNewHead!.random?.next
            myNewHead = next
        }
        
        // 还原原始链表，即分离原链表和克隆链表
        //        最后一步拆分有点奇怪，我写的是这个，节点也都变了 但是leetcode 提交说我没复制
        var myFinalHead = head!.next
        var result = myFinalHead
        while myFinalHead != nil {
            var next = myFinalHead!.next?.next
            myFinalHead!.next = myFinalHead!.next?.next
            myFinalHead = next
        }
        return result
        
        // 答案写的是这个，同样也是拆分，位移不同的是  他直接吧两个都拆开了，但是我只把最后的结果拆出来，都能理解，但是有点奇怪
        var sliderNode = head
        var finalResult = sliderNode!.next
        while sliderNode != nil {
            var next = sliderNode!.next
            sliderNode!.next = sliderNode!.next?.next
            sliderNode = next
        }
        return finalResult
        
    }
    
    //  54 螺旋矩阵
    @objc func spiralOrder_54() -> Void {
        let matrix = [[1,2,3],
                      [4,5,6],
                      [7,8,9]]
        
        //        123698745
        //        思想是一致沿着外圈遍历，然后不断缩小包围圈 （上下左右边界）
        self.showAlert(title: "spiralOrder_54", message: "\(self.spiralOrder(matrix))")
    }
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var v = matrix.count
        var h = matrix[0].count
        if v * h == 0 {
            return [-1]
        }
        
        var up = 0
        var bottom = v - 1
        var left = 0
        var right = h - 1
        var resultArr = [Int]()
        
        self.calculate(matrix: matrix, resultArr: &resultArr, up: up, bottom: bottom, left: left, right: right)
        
        return resultArr
    }
    
    func calculate(matrix: [[Int]], resultArr: inout[Int], up:Int, bottom:Int, left:Int, right:Int) -> Void {
        var up = up
        var bottom = bottom
        var left = left
        var right = right
        
        //        上
        for i in left ... right {
            resultArr.append(matrix[up][i])
        }
        up += 1
        if up > bottom {
            return
        }
        
        //   右
        for i in up ... bottom {
            resultArr.append(matrix[i][right])
        }
        right -= 1
        if left > right {
            return
        }
        
        //        下
        for i in (left ... right).reversed() {
            resultArr.append(matrix[bottom][i])
        }
        bottom -= 1
        if up > bottom {
            return
        }
        
        //        左
        for i in (up ... bottom).reversed() {
            resultArr.append(matrix[i][left])
        }
        left += 1
        if left > right {
            return
        }
        
        self.calculate(matrix: matrix, resultArr: &resultArr, up: up, bottom: bottom, left: left, right: right)
    }
    
    //    21 合并两个有序链表
    @objc func mergeTwoLists_21() -> Void {
        //        234  564
        //        234456
        let code = self.mergeTwoLists(self.l11, self.l21)
        self.showAlert(title: "mergeTwoLists_21", message: "\(code)")
    }
    
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var sliderL1 = list1
        var sliderL2 = list2
        var resultSliderHead = ListNode(-1)
        var resultHead = resultSliderHead
        while sliderL1 != nil && sliderL2 != nil{
            if sliderL1!.val >= sliderL2!.val {
                resultSliderHead.next = sliderL2
                sliderL2 = sliderL2!.next
            } else {
                resultSliderHead.next = sliderL1
                sliderL1 = sliderL1!.next
            }
            resultSliderHead = resultSliderHead.next!
        }
        
        if sliderL2 != nil {
            resultSliderHead.next = sliderL2
        }
        
        if sliderL1 != nil {
            resultSliderHead.next = sliderL1
        }
        
        return resultHead.next
    }
    
    @objc func reverseWords_151() -> Void {
        let s = "the     sky  is         blue"
        self.showAlert(title: "reverseWords_151", message: "\(self.reverseWords(s))")
    }
    
    func reverseWords(_ s: String) -> String {
        let str = Array(s)
        var left = 0
        var right = s.count - 1
        var result = [Character]()
        
        //        先去除头尾空格
        while str[left] == " " || str[right] == " "  {
            if str[left] == " " {
                left += 1
            }
            
            if str[right] == " " {
                right -= 1
            }
        }
        
        //        去除单词间多余的空格
        for i in (left ... right) {
            if str[i] == " " {
                if i > 0 && i < str.count - 1 {
                    if (str[i - 1] != " ") {
                        result.append(str[i])
                    }
                }
            } else {
                result.append(str[i])
            }
        }
        
        //        开始反转
        var resultStrArr = [Character]()
        var count = 0
        for i in 0 ..< result.count {
            if result[i] == " " {
                resultStrArr.insert(result[i], at: 0)
                count = 0
            } else {
                resultStrArr.insert(result[i], at: count)
                count += 1
            }
        }
        return resultStrArr.map({String($0)}).joined()
    }
    
    //  字符串转换为整数
    @objc func myAtoi_8() -> Void {
        
        let s = " "
        self.showAlert(title: "myAtoi_8", message: "\(self.myAtoi(s))")
    }
    
    func myAtoi(_ s: String) -> Int {
        let strArr = s.map({String($0)})
        var index = 0
        var result = 0
        var flage = 1
        
        if s.count < 1 {
            return 0
        }
        
        //        处理空格
        while index < s.count && strArr[index] == " " {
            index += 1
        }
        
        //        处理符号
        if index < strArr.count && (strArr[index] == "+" || strArr[index] == "-") {
            if strArr[index] == "-" {
                flage = -1
            }
            index += 1
        }
        
        //        处理数字
        while index < strArr.count && Int(strArr[index]) ?? -1 >=  0 {
            var lastNum = 7
            if flage < 0 {
                lastNum = Int(Int32.min) % 10 * flage
            }
            
            if result > Int(Int32.max / 10) || (result == Int(Int32.max / 10) && Int(strArr[index])! > lastNum) {
                return flage > 0 ? Int(Int32.max) : Int(Int32.min)
            }
            //            在数字中移动指针，比较巧妙
            result = result * 10 + Int(strArr[index])!
            index += 1
        }
        return result * flage
    }
    
    @objc func firstMissingPositive_41() -> Void {
        let nums = [1,2,3]
        self.showAlert(title: "firstMissingPositive_41", message: "\(self.firstMissingPositive(nums))")
    }
    
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        
        //        先判断是否里面有1  没有就直接返回1
        if !nums.contains(1) {
            return 1
        }
        
        //        把负数 0  都用1 来替换 因为这些我们根本用不到
        for i in 0 ..< nums.count {
            let tmpNum = nums[i]
            if tmpNum <= 0 {
                nums[i] = 1
            }
        }
        
        //        上一步替换好的数组后应该里面都是正整数了，我们现在来开始记录哪个正整数没有出现过，用数组下标来代表数组中的正整数，如果该数出现过，那么下标为 ”该数 - 1“ 的元素打个标记（绝对值为-1，防止被多次置位-1 所以取绝对值）因为0不是正整数，我们不考虑0，但是第0位置不能空着，所以是  ”该数 - 1“ 下标
        for i in 0 ..< nums.count {
            //            注意这一步取值的时候要用绝对值
            let index = abs(nums[i]) - 1
            if index < nums.count {
                //            注意这一步取值的时候要用绝对值
                nums[index] = abs(nums[index]) * -1
            }
        }
        
        //        上一步打完标记后再从头（从0）遍历数组  第一个大于0（没有被打标记）的位置就是缺失的正整数
        for i in 0 ..< nums.count {
            let tmpNum = nums[i]
            if tmpNum > 0 {
                return i+1
            }
        }
        
        //        如果全部被打了标记，说明最小正整数就是数组count + 1  比如 1 2 3   就缺了 4
        return nums.count + 1
        /**************************************方法二******************************************************************/
        //        用的哈希表（字典）空间复杂度不满足要求
        var numDic:[Int : Int] = [Int : Int]()
        var maxNum = 0
        for i in 0 ..< nums.count {
            var tmpNum = nums[i]
            maxNum = max(maxNum, tmpNum)
            numDic[tmpNum] = i
        }
        
        for i in 1 ... maxNum + 1 {
            let hasNum = numDic[i]
            if hasNum == nil {
                return i
            }
        }
        return -1
    }
    
    //    三数之和  O(n2) 外层循环 找出第一个数 然后双指针找两数之和
    @objc func threeSum_15() -> Void {
        let nums = [-1,0,1,2,-1,-4]
        self.showAlert(title: "threeSum_15", message: "\(self.threeSum(nums))")
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        //        先排序数组
        let myArr = nums.sorted(by: {$0<$1})
        var finalArr = [[Int]]()
        
        //        开始遍历
        for i in 0 ..< myArr.count - 1 {
            let minNum = myArr[i]
            let targetNum = 0 - minNum
            //            如果下一个元素和上一个一样就先跳过，不然会有重复的
            if i > 0 && myArr[i] == myArr[i - 1] {
                continue
            }
            
            //            a+b+c=0 必须满足a<b<c 才能保证不重复，不然三个数顺序随便一换也等于0 但是会重复。所以 外层a最小，b中间（left） c最大（right）
            var left = i + 1
            var right = nums.count - 1
            while left < right {
                let leftNum = myArr[left]
                let rightNum = myArr[right]
                //                如果两数字的和大了，那就减小点  右侧的左移
                if leftNum + rightNum > targetNum {
                    right -= 1
                } else if leftNum + rightNum < targetNum {
                    //                    如果两数字的和小了，那就大点  右侧的右移
                    left += 1
                } else {
                    //                    如果等于零了 正好 就加到数组里面
                    finalArr.append([leftNum, minNum, rightNum])
                    
                    //                    加完之后不要高兴的太早，看下剩下的元素里面是否还有和当前的a相加为0的情况
                    //                    同样如果是相同的就跳过，不然就重复了
                    while left < right && myArr[left] == myArr[left + 1] {
                        left += 1
                    }
                    while left < right && myArr[right] == myArr[right - 1] {
                        right -= 1
                    }
                    //                    指针移动准备先下一此循环
                    left += 1
                    right -= 1
                }
            }
        }
        return finalArr
    }
    
    
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }
    
    // 二叉树好节点的个数  递归dfs深度优先遍历
    @objc func goodNodes_1448() -> Void {
        let tree:TreeNode = TreeNode(100)
        self.showAlert(title: "goodNodes_1448", message: "\(self.goodNodes(_:tree))")
    }
    var res = 0
    
    func goodNodes(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var rootNum = root!.val
        self.readNode(rootNum: &rootNum, root: root!)
        return res
    }
    
    func readNode(rootNum: inout Int, root: TreeNode?) -> Void {
        guard let root = root else {
            return
        }
        
        //        var rootNum = rootNum
        if root.val >= rootNum {
            self.res += 1
            rootNum = 99
        }
        self.readNode(rootNum: &rootNum, root: root.left)
        self.readNode(rootNum: &rootNum, root: root.right)
    }
    
    @objc func topKFrequent_347() -> Void {
        let nums = [1,1,1,2,2,3]
        let k = 2
        self.showAlert(title: "topKFrequent_347", message: "\(self.topKFrequent(nums, k))")
    }
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        
        if nums.count == 0 {
            return []
        }
        
//        方法1 暴力破解  数组加字典[元素：出现次数]
//        var numDic = [Int:Int]()
//        var res = [Int]()
//        for i in 0 ..< nums.count {
//            let tmpNum = nums[i]
//            if numDic[tmpNum] != nil {
//                numDic[tmpNum]! += 1
//            } else {
//                numDic[tmpNum] = 1
//            }
//        }
//
//        var count = 0
//        if k < numDic.count {
//            count = numDic.count - k
//        }
//        while numDic.count > count {
//            var maxNum = 0
//            var needRemove = 0
//            for i in 0 ..< nums.count {
//                let count = numDic[nums[i]] ?? 0
//                if count >= maxNum {
//                    maxNum = count
//                    needRemove = nums[i]
//                }
//            }
//            numDic.removeValue(forKey: needRemove)
//            res.append(needRemove)
//        }
//
//        return res
        
        
        //        方法2
        // 创建一个字典 key：出现的次数   value：该次数所对应的元素们   即都有哪些元素出现了 key次
        var countDic = [Int:[Int]]()
        
        // 创建一个字典 key：数组中的数   value：该数出现的次数
        var numDic = [Int:Int]()
        
        // 保存最后的结果
        var res = [Int]()
        // 开始遍历 把数组转为  numDic
        for i in 0 ..< nums.count {
            let tmpNum = nums[i]
            if numDic[tmpNum] != nil {
                numDic[tmpNum]! += 1
            } else {
                numDic[tmpNum] = 1
            }
        }
        
        //        在进行遍历把numDic 转为 countDic
        for (num, count) in numDic{
            var numsArr = countDic[count]
            if numsArr == nil {
                countDic[count] = [num]
            } else {
                countDic[count]?.append(num)
            }
        }
        
        //        逆序从countDic中取出元素 拼接到res上，直到res的长度为k
        for i in (0 ... nums.count).reversed() {
            let numsArr = countDic[i]
            //            如果该次数下没有 对应的数字就continue
            if numsArr == nil {
                continue
            }
            
            //            如果大于K个 就直接中断并返回
            if res.count >= k {
                break
            }
            res = res + numsArr!
        }
        return res
    }

    //  二叉树的右视图 直接用广度优先遍历
    @objc func rightSideView_199() -> Void {
        let tree:TreeNode = TreeNode(100)

        self.showAlert(title: "rightSideView_199", message: "\(self.rightSideView(tree))")
    }
    
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var res = [Int]()
        self.readNode(resArr: &res, nodeArr: [root])
        return res
    }
    
    func readNode(resArr:inout [Int], nodeArr:[TreeNode]) -> Void {
        if nodeArr.count == 0 {
            return
        }
        var tmpArr:[TreeNode] = Array()
        let lastNode = nodeArr.last!
        resArr.append(lastNode.val)
        for i in (0 ..< nodeArr.count) {
            let tmpNode = nodeArr[i]
            if tmpNode.left != nil {
                tmpArr.append(tmpNode.left!)
            }
            if tmpNode.right != nil {
                tmpArr.append(tmpNode.right!)
            }
        }
        self.readNode(resArr: &resArr, nodeArr: tmpArr)
    }
                            
    
    @objc func ImplementQueueWithStack_232() -> Void {
        self.showAlert(title: "ImplementQueueWithStack_232", message: "考点为：如何使用栈（先进后出的结构）来模拟队列（先进先出的结构）。这道题我就不写了，方法为 创建两个数组，要注意的是因为是要用栈来模拟队列，所以这两个数组必须是栈，只能先进后出，不能直接firstObj那样取值，遍历也要逆序遍历，创建两个数组，A 和 B ，把A遍历放到B的过程就是颠倒先后顺序的过程，也是此题的考点")
    }
    
    // 打家劫舍  动态规划
    @objc func rob_198() -> Void {
        let nums = [1,2,3,1]
        self.showAlert(title: "rob_198", message: "\(self.rob(nums))")
    }
    
    func rob(_ nums:[Int]) -> Int {
        
//        如果是0个 直接返回0 一个都偷不了
        if nums.count == 0 {
            return 0
        }
        
//        如果只有一个  那就偷这一个了
        if nums.count == 1 {
            return nums[0]
        }
        
//        如果 有两个及其以上就有两种情况
//        1：我偷第N个 + 我偷第0~n-2个，因为不能连着偷
//        2：我直接偷 n-1个
//        所以上面两种情况取最大值就是我能偷的最多的钱 max(情况1, 情况2)
//        因为第N个我能通过遍历直接拿到，所以我还缺两个指针
        
//        1：0~n-2的钱，我们称为first
        var first = nums[0]
        
//        2：0~n-1的钱我们称为second
        var second = max(nums[0], nums[1])
        
//        开始遍历数组，因为只含一个的元素的情况被我们之前排除了；只含有两个元素的情况就是second初始化的值。所以这里从2开始遍历
        for i in 2 ..< nums.count {
            
//            先把second的值保存下，因为后面要更新他的值 且他的值还会给别人 所以要先保存下
            let tmp = second
            
//            将0~i的钱存到second里面
            second = max(second, nums[i] + first)
            
//            将tmp的值赋给first，注意这个tmp取得是second进行本次循环前的值，所以他是不包含本次循环的，也就是0~i-1的钱，在下一次循环中i+1后就满足了
//            second为0~i-1  first为0~i-2  所以这次再回去看上一行代码是不是就懂了
            first = tmp
        }
        
//        最后因为要求的就是0 ~ i 的钱，所以返回second
        return second
   }
    
//    求平方根 使用二分查找
    @objc func mySqrt_69() -> Void {
        self.showAlert(title: "mySqrt_69", message: "\(self.mySqrt(8))")
    }
    
    func mySqrt(_ x: Int) -> Int {
        
//        明确几点
//        1：要知道遍历的起止位置  起点肯定是0 终点就是x
//        2：要知道本身已经是一个有序的数组了，需要在有序数组中查找元素 效率最高的就是二分查找（两个指针一头一尾 再加个中间节点）
//        3：一看到这种开平方的 指数级别的，基本都跑不了二分查找
//        4：知道 a^2 <= x 其中所有a 的最大值就是答案
        
        var left = 0
        var right = x
        var res = 0
        while left <= right {
            var middle = left + (right - left) / 2
            if middle * middle <= x {
//                这里主要满足条件后先赋值不要着急返回，因为可能后面还有更大的
                res = middle
                left = middle + 1
            } else {
                right = middle - 1
            }
        }
        return res
    }
    
    //  返回和为0 的数
    @objc func sumZero_1304() -> Void {
        self.showAlert(title: "sumZero_1304", message: "\(self.sumZero(2))")
    }
    
    func sumZero(_ n: Int) -> [Int] {
        //        题不难，但是要注意边界情况
        if n == 0  {
            return []
        }
        
        if n == 1 {
            return [0]
        }
        
        var currentSum = 0
        var res = [Int]()
        for i in 0 ... n - 1  {
            if i != n - 1 {
                currentSum += (i + 1)
                res.append(i + 1)
            } else {
                res.append(currentSum * -1)
            }
        }
        return res
    }
    
    // 数组元素乘积的符号
    @objc func arraySign_1822() -> Void {
        let nums = [-1,-2,-3,-4,3,2,1]
        self.showAlert(title: "arraySign_1822", message: "\(self.arraySign(nums))")
    }
    
    func arraySign(_ nums: [Int]) -> Int {
        
        //        方法一 ：算负数的个数
//        var numberCount = 0
//        for i in 0 ..< nums.count {
//            if nums[i] == 0 {
//                return 0
//            }
//            if nums[i] < 0 {
//                numberCount += 1
//            }
//        }
//
//        if numberCount % 2 == 0 {
//            return 1
//        }
//        return -1
        
//        方法二 ：用一个标记位来表示zheng'fu's
        var mark = 1
        for i in 0 ..< nums.count {
            if nums[i] == 0 {
                return 0
            }
            if nums[i] < 0 {
                mark *= -1
            }
        }
        return mark
    }
    
    var k = 0
    var kth = 0
    // 数组第K大元素  经典的Top K问题！！！！！！
//    使用快速排序 但是要注意 可以通过判断 middle和 k的位置再决定是对左侧排序还是对右侧排序。不要一上来无脑左右来一次
    @objc func findKthLargest_215() -> Void {
        let nums = [3,2,1,5,6,4]
        let k = 2
        self.showAlert(title: "findKthLargest_215", message: "\(self.findKthLargest(nums, k))")
    }
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        self.k = k
        self.quickSort(nums: &nums, left: 0, right: nums.count - 1)
        return self.kth
    }
    
    func quickSort(nums:inout [Int], left:Int, right:Int) -> Void {
        if left >= right {
            self.kth = nums[left]
            return
        }
        let middle = self.partition(nums: &nums, left: left, right: right)
        if middle == nums.count - self.k {
            self.kth = nums[middle]
            return
        }
        
        if middle < nums.count - self.k {
            self.quickSort(nums: &nums, left: middle + 1, right: right)
        } else if middle > nums.count - self.k {
            self.quickSort(nums: &nums, left: left, right: (middle - 1))
        }
    }
    
    func partition(nums:inout [Int], left: Int, right: Int) -> Int {
        let standard = nums[right]
        var currentIndex = left
        for i in left ..< right {
            let tmp = nums[i]
            if tmp <= standard {
                nums.swapAt(currentIndex, i)
                currentIndex += 1
            }
        }
        nums.swapAt(currentIndex, right)
        return currentIndex
    }
    
    //    安排电影院座位
    @objc func maxNumberOfFamilies_1386() -> Void {
        let reservedSeats = [[4,3],[1,4],[4,6],[1,7]]
        let n = 4
       
        self.showAlert(title: "maxNumberOfFamilies_1386", message: "\(self.maxNumberOfFamilies(n, reservedSeats))")
    }
    
    func maxNumberOfFamilies(_ n: Int, _ reservedSeats: [[Int]]) -> Int {
        

//        座位和关系放到字典里 key就是行  value 就是一个数组 包含该行的座位
        var res = 0
        var dict: Dictionary<Int, [Int]> = Dictionary<Int,[Int]>()
        for element in reservedSeats {
            var list = dict[element[0]]
            if (list == nil){
                list = [Int]()
            }
            list!.append(element[1])
            dict[element[0]] = list
        }
        res = 2*n
//        把座位数组变成 11111111的形式
        for (_, seatList) in dict {
            var rowSeats: [Int] = [Int](repeating: 1, count: 10)
            for element in seatList {
                rowSeats[element-1] = 0
            }
            //计算这一行实际的数量
            res = res - 2 + calculateCount(rowSeats)
        }
        return res
    }
    
    func calculateCount(_ list: [Int]) -> Int {
        var count = 0
//        判断1 到 4 能做不
        if (isTrue(1, 4, list)){
            count = count + 1
            
//            如果1 到4 可以做，再看看5到8能做不
            if (isTrue(5, 8, list)){
                count = count + 1
            }
        }else{
            
//            如果1到4都不能做就看3到6能做不 因为有可能之所以1到4不能做是因为1 2 有人，所以这时候3到6是可以做的
            if (isTrue(3, 6, list)){
                count = count + 1
//                如果3到6 可以做 那么5到8肯定做不了了
            }else{
                //反之判断5到8 能否做人
                if (isTrue(5, 8, list)){
                    count = count + 1
                }
            }
        }
        return count
    }
    
    //用来判断在[start, end]之间,是否全部为1
    func isTrue(_ start: Int, _ end: Int, _ list: [Int]) -> Bool {
        for index in start..<end+1 {
            if (list[index] == 0){
                return false
            }
        }
        return true
    }
}
