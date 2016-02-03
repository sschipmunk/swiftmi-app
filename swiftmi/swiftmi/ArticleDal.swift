//
//  ArticleDal.swift
//  swiftmi
//
//  Created by yangyin on 16/2/3.
//  Copyright © 2016年 swiftmi. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class ArticleDal:NSObject {
    
    func addList(items:[AnyObject]) {
        
        for po in items {
            
            self.addArticle(po, save: false)
        }
        
        CoreDataManager.shared.save()
    }
    
    func addArticle(obj:AnyObject,save:Bool){
        
        
        let context=CoreDataManager.shared.managedObjectContext;
        
        
        let model = NSEntityDescription.entityForName("Article", inManagedObjectContext: context)
        
        let article = Article(entity: model!, insertIntoManagedObjectContext: context)
        
        if model != nil {
 
            self.obj2ManagedObject(obj, article:article)
            
            if(save)
            {
                CoreDataManager.shared.save()
                
            }
        }
    }
    
    func deleteAll(){
        
        CoreDataManager.shared.deleteTable("Article")
    }
    
    func save(){
        let context=CoreDataManager.shared.managedObjectContext;
        do {
            try context.save()
        } catch _ {
        }
    }
    
    func getList()->[AnyObject]? {
        
        let request = NSFetchRequest(entityName: "Article")
        let sort1=NSSortDescriptor(key: "articleId", ascending: false)
        
        request.fetchLimit = 30
        request.sortDescriptors = [sort1]
        request.resultType = NSFetchRequestResultType.DictionaryResultType
        let result = CoreDataManager.shared.executeFetchRequest(request)
        return result
        
    }
    
    func obj2ManagedObject(obj:AnyObject,article:Article) -> Article{
        
        var data = JSON(obj)
        
        let articleId = data["articleId"].int64!
        let title = data["title"].string!
        let content = data["content"].string
        let createDate = data["createDate"].int64!
        let viewCount = data["viewCount"].int64!
        let siteId = data["siteId"].int64!
        let sourceName = data["sourceName"].string
        let sourceUrl = data["sourceUrl"].string
        let author = data["author"].string
        let language = data["language"].string
        let imageUrl = data["imageUrl"].string
   
        article.articleId = articleId
        article.title = title;
        article.content = content;
        article.createDate = createDate
        article.siteId = siteId
        article.sourceName = sourceName
        article.viewCount = viewCount
        article.sourceUrl = sourceUrl
        article.author = author
        article.language = language
        article.imageUrl = imageUrl
        
        return article;
    }
}