//
//  JSONDownloader.swift
//  Stormy
//
//  Created by Iván Martínez on 24/09/17.
//  Copyright © 2017 Iván Martínez. All rights reserved.
//

import Foundation

class JSONDownloader {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONCompletionHandler = (JSON?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> URLSessionTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("We couldn't get the http response")
                completionHandler(nil)
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completionHandler(json)
                    } catch {
                        print("We couldn't transform the data")
                        completionHandler(nil)
                    }
                    
                } else {
                    print("We couldn't get the data")
                    completionHandler(nil)
                }
            } else {
                print("Invalid http response")
                completionHandler(nil)
            }
        }
        
        return task
    }
}
