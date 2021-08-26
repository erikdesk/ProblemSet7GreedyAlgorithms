import Foundation

func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
    var sorteds = intervals
    sorteds.sort { $0[0] < $1[0] }
    
    for i in 0..<sorteds.count-1 {
        if sorteds[i+1][0] < sorteds[i][1] {
            return false
        }
    }
    return true
}

func partitionLabels(_ s: String) -> [Int] {
    let c = Array(s)
    //print(s)
    //print(c[2])
    
    var nextPartitionStart = 0
    var maxLastIndex = Int.min
    var result = [Int]()
    
    for i in 0..<c.count {
        let lastIndex = c.lastIndex(of: c[i])!
        if maxLastIndex < lastIndex { maxLastIndex = lastIndex }
        //print(c[i], i, lastIndex, maxLastIndex)
        
        if maxLastIndex == i {
            //print(nextPartitionStart, maxLastIndex)
            result.append(String(c[nextPartitionStart...maxLastIndex]).count)
            nextPartitionStart = i + 1
        }
    }
    
    return result
}

func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    
    // Use collection to get total counts of each process.
    var counts = [Character: Int]()
    for task in tasks { counts[task] = (counts[task] ?? 0) + 1 }
    //print(counts)
    
    // Use tuple so can be sorted in descending order.
    var items = [(Character, Int, Int)]()
    for item in counts {
        items.append((item.key, item.value, 0))
    }
    items.sort { $0.1 > $1.1 }
    
    //print(items)
    
    // Loop until all pending processes is 0.
    var total = 0
    while items.reduce(0, { $0 + $1.1 }) > 0 {
        var isPlaced = false
        var i = 0
        while !isPlaced && i < items.count {
            if items[i].1 > 0 && items[i].2 == 0 {
                //print(items[i].0)
                total += 1
                isPlaced = true
                items[i].1 -= 1
                items[i].2 = n + 1
            }
            
            //print(items)
            i += 1
        }
        
        // Nothing got placed.
        if !isPlaced {
            total += 1
            //print(".")
        }
        
        // Decrement all cooldowns.
        items = items.map { ($0.0, $0.1, $0.2 > 0 ? $0.2 - 1 : 0) }
        
        //print("--")
    }
    
    return total
}


//
//var itemMaps = [[String?]]()
//
//for item in counts {
//    var arr = [String?]()
//    for i in 0..<item.value {
//        for j in 0..<n {
//            arr.append(j == 0 ? String(item.key) : nil)
//        }
//    }
//    itemMaps.append(arr)
//}
//
//for i in itemMaps {
//    print(i)
//}


//
//    var taskArr = zip(Array(taskCol.keys), Array(taskCol.values)).map { (String($0), Int($1)) }
//    taskArr.sort { $0.1 > $1.1 }
//
//    let q = Queue<(String, Int)>()
//    var idles = [String: Int]()
//    for item in taskArr {
//        q.enqueue(item: item)
//        idles[item.0] = 0
//    }
//
//    print(q)
//    print(idles)
//    print("---")
//
//    while !q.isEmpty() {
//        var item = q.dequeue()!
//
//        if idles[item.0] == 0 {
//            item.1 -= 1
//            idles[item.0] = 2
//            print(item)
//
//            if item.1 > 0 {
//                q.enqueue(item: item)
//            }
//        }
//    }
//
//
//
//
//    print(pendingTasks)
//
//    var lastTask = ""
//    while remainingTasksCount > 0 {
//
//
//        remainingTasksCount = pendingTasks.reduce(0, { $0 + $1.1 })
//    }
//
//    return 0
//}
