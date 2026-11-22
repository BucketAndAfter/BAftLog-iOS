//
//  GetAllList.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 11/2/26.
//

import Foundation
import SwiftData

@Model
class BucketInfo {
    var isDone : Bool
    var name : String
    var moreInfo : String
    var thoughts : String
    var date : String
    
    init(isDone : Bool, name : String, moreInfo : String, thoughts : String, date : String?) {
        self.isDone = isDone
        self.name = name
        self.moreInfo = moreInfo
        self.thoughts = thoughts
        self.date = date ?? "달성일 미기록"
    }
}
