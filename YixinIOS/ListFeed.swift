//
//  ListFeed.swift
//  YixinIOS
//
//  Created by zeng tim on 24/8/2017.
//  Copyright © 2017年 zeng tim. All rights reserved.
//

import Foundation
import UIKit

class ListFeed{
    var mainImage:UIImage
    var title:String = ""
    var alias :String = ""
    
    init(title:String,mainImage:UIImage,alias:String) {
        self.title = title
        self.mainImage = mainImage
        self.alias = alias
    }
}
