//
//  Model.swift
//  NewsProject
//
//  Created by Admin on 29.07.2022.
//

import Foundation
import UIKit

struct NewsModel {
    var title = String()
    var author = String()
    var description = String()
    var date = String()
    var url: URL!
    var urlToImage: URL
}

class Model {
 
    public static let shared  = Model()
    
    let defaultUrl =  URL(string: "https://1.bp.blogspot.com/--b7JV7PgDPo/Xj6jliViqZI/AAAAAAAAC60/NO3XtMYWHR00NPBc-a_wxlkszqLEB07QACLcBGAsYHQ/s1600/record.jpg")!

    let dateFormatter = DateFormatter()
    
    public func getData(completionBlock: @escaping ([NewsModel]) -> Void) {
    
         //Insert your API key here
         let url = URL(string: "")
         
         guard let unwrUrl = url else { return  }
         
         var request = URLRequest(url: unwrUrl)
         
         request.httpMethod = "GET"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         
         let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
             self.dateFormatter.dateFormat = "HH:mm MM.dd.yyyy"
             
             if let data = data {
                 do {
                     var newsArray = [NewsModel]()
                     let json = try! JSONSerialization.jsonObject(with: data, options: [])
                                   
                     
                                   guard let jsonData = json as? [String:Any] else { return }
                                   if let arrayNews = jsonData["articles"] as? NSArray {
                      
                                     for news in arrayNews {
                                       guard let currentNews = news as? [String:Any] else { return }
                      
                                       var currentTitle: String = "Without title"
                                       if let title = currentNews["title"] as? String {
                                         currentTitle = title
                                       }
                      
                                       let datePublishedAt = currentNews["publishedAt"] as! String
                                       let convertedDate = self.dateFormatter.date(from: datePublishedAt)
                      
                                       var currentAuthor: String = "Without author"
                                       if let author = currentNews["author"] as? String {
                                         currentAuthor = author
                                       }
                      
                                       var currentDescription: String = "Without description"
                                       if let description = currentNews["description"] as? String {
                                         currentDescription = description
                                       }
                      
                                       var currenURL: URL = self.defaultUrl
                                       if let urlString = currentNews["url"] as? String {
                                           var url = URL(string: urlString)
                                           guard let unwrUrl = url else { return }
                                         currenURL = unwrUrl
                                       }
                      
                                       var currentImageURL: URL = self.defaultUrl
                                       if let imageString = currentNews["urlToImage"] as? String {
                                         if imageString.isEmpty{
                                           currentImageURL = self.defaultUrl
                                         }else {
                                           currentImageURL = URL(string: imageString) ?? self.defaultUrl
                                         }
                                       }
                                         newsArray.append(NewsModel(title: currentTitle, author: currentAuthor, description: currentDescription, date: datePublishedAt, url: currenURL, urlToImage: currentImageURL))
                                         
                                   }
                                       
                         completionBlock(newsArray)
                         }
                 }
             }
         }
         task.resume()
     }
 
}

public enum RequestsError: Error {
    
    case imageNotFound
}
