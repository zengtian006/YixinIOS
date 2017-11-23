//
//  ListFeedLine.swift
//  YixinIOS
//
//  Created by zeng tim on 24/8/2017.
//  Copyright © 2017年 zeng tim. All rights reserved.
//

import Foundation
import UIKit

class ListFeedLine{
    var feedList : [ListFeed]
    
    init(feedList:[ListFeed]) {
        self.feedList = feedList
    }
    
    class func yixinFeedLines() -> ListFeedLine{
        return self.yixins()
    }
    class func newsFeedLines() -> ListFeedLine{
        return self.news()
    }
    class func productsFeedLines() -> ListFeedLine{
        return self.products()
    }
    
    private class func yixins() -> ListFeedLine{
        var feeds = [ListFeed]()
        feeds.append(ListFeed(title: "内分泌",mainImage:#imageLiteral(resourceName: "内分泌"),alias:"endocrine"))
        feeds.append(ListFeed(title: "心血管",mainImage:#imageLiteral(resourceName: "心脏"),alias:"cardiology"))
        feeds.append(ListFeed(title: "眼科",mainImage:#imageLiteral(resourceName: "眼科"),alias:"ophthalmology"))
        feeds.append(ListFeed(title: "精神科",mainImage:#imageLiteral(resourceName: "精神"),alias:"psychiatry"))
        feeds.append(ListFeed(title: "肝脏科",mainImage:#imageLiteral(resourceName: "肝脏"),alias:"hepatology"))
        feeds.append(ListFeed(title: "肠胃",mainImage:#imageLiteral(resourceName: "肠胃"),alias:"gastroenterostomy"))

        return ListFeedLine(feedList: feeds)
    }
    
    private class func news() -> ListFeedLine{
        var feeds = [ListFeed]()
        feeds.append(ListFeed(title: "健康贴士",mainImage:#imageLiteral(resourceName: "健康贴士"),alias:"health_tips"))
        feeds.append(ListFeed(title: "旅游警示",mainImage:#imageLiteral(resourceName: "旅游警示"),alias:"travel_warning"))
        
        return ListFeedLine(feedList: feeds)
    }
    
    private class func products() -> ListFeedLine{
        var feeds = [ListFeed]()
        feeds.append(ListFeed(title: "常见药物",mainImage:#imageLiteral(resourceName: "常见药物"),alias:"common_medications"))
        feeds.append(ListFeed(title: "防疫疫苗",mainImage:#imageLiteral(resourceName: "防疫疫苗"),alias:"vaccine"))
        feeds.append(ListFeed(title: "医疗器械",mainImage:#imageLiteral(resourceName: "医疗器械"),alias:"medical_instruments"))
        feeds.append(ListFeed(title: "保健产品",mainImage:#imageLiteral(resourceName: "保健产品"),alias:"health_care"))
        feeds.append(ListFeed(title: "检查项目",mainImage:#imageLiteral(resourceName: "检查项目"),alias:"physical_examination"))
        
        return ListFeedLine(feedList: feeds)
    }
}
