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
                            "LRUCache_146"];
    
    
    
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
        self.view.addSubview(mainTable)
    }
    
    
    
    @objc func twoSum_1() {
        self.showAlert(title: "第1题twoSum", message: self.twoSum([3,2,4], 6).debugDescription)
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
    
    //LRU
    @objc func LRUCache_146() -> Void {
//        ["LRUCache","get","put","get","put","put","get","get"]
//        [[2],[2],[2,6],[1],[1,5],[1,2],[1],[2]]
        let LRUCache = LRUObj(2)
        LRUCache.get(2); // 缓存是 {1=1}
        LRUCache.put(2, 6); // 缓存是 {1=1, 2=2}
        LRUCache.get(1);    // 返回 1
        LRUCache.put(1, 5); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
        LRUCache.put(1,2);    // 返回 -1 (未找到)
        LRUCache.get(1);    // 返回 -1 (未找到)
        LRUCache.get(2);    // 返回 3

//        self.showAlert(title: "LRUCache_146", message: "\(self.maxProfit(arr))")
    }
}
