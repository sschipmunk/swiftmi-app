//
//  SplotLightHelper.swift
//  swiftmi
//
//  Created by yangyin on 15/11/2.
//  Copyright © 2015年 swiftmi. All rights reserved.
//

import CoreSpotlight
import MobileCoreServices


open class SplotlightHelper:NSObject
{
    static var domainIdentifier:String = Bundle.main.bundleIdentifier!;
    
    class func AddItemToCoreSpotlight(_ id:String,title:String,contentDescription:String)
    {
        
        if #available(iOS 9.0, *) {
            
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attributeSet.title = title;
            attributeSet.contentDescription = contentDescription;
            
            let item = CSSearchableItem(uniqueIdentifier: id, domainIdentifier: domainIdentifier, attributeSet: attributeSet)
            
            // expire after a month
            item.expirationDate = Date(timeInterval: 30*24*60*60, since:Date())
            CSSearchableIndex.default().indexSearchableItems([item], completionHandler: { error -> Void in
                
                if let err = error
                {
                    print("index error:\(err.localizedDescription)")
                }else{
                    print("index success")
                }
                
            })
            
            
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    class func RemoveItemFromCoreSplotlight(_ id:String)
    {
        if #available(iOS 9.0, *) {
            CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: [id]) { error -> Void in
                if let err = error {
                    print("remove index error: \(err.localizedDescription)")
                } else {
                    print("Search item successfully removed!")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}
