//
//  APICaller.swift
//  News  App
//
//  Created by Meghna on 04/06/22.
//

import Foundation


final class APICaller{
    static let share = APICaller()
    
    struct Constants {
        static let topHeadLineURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=NewsApi key")
    }
    private init(){
    }
    public func getTopStories(completion : @escaping (Result<[Article], Error>)-> Void){
        guard let url = Constants.topHeadLineURL else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data , _, error in
            if let error =  error{
                completion(.failure(error))
            }
            else if let data = data{
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articls : \(result.articles.count)")
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


struct APIResponse: Codable {
    let articles : [Article]
}

struct Article : Codable {
    
    let source: Source
    let title : String
    let description :  String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
}
struct Source : Codable {
    let name : String
}
