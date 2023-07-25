//
//  HTTPRequestClient.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import Foundation


struct BlankCodable: Codable{}

class HTTPRequestClient<T: Codable>{
    
    let builder: Builder
    
    let queue = DispatchQueue(label: "co.tryterra.http.requests")
    
    init(_ builder: Builder){
        self.builder = builder
    }
    
    class Builder{
        var method: String = "GET"
        var url: String?
        var headers: [String: String] = [:]
        var body: [String: String] = [:]
        var input: T.Type? = nil
        var output: String? = nil
        
        enum HTTPMethods{
            case POST, GET, DELETE
        }
        
        func setMethod(_ method: HTTPMethods) -> Builder{
            switch(method){
            case .GET:
                self.method = "GET"
            case .POST:
                self.method = "POST"
            case .DELETE:
                self.method = "DELETE"
            }
            return self
        }
        
        func setUrl(_ url: String) -> Builder{
            self.url = url
            return self
        }
        
        func setHeaders(_ headers: [String: String]) -> Builder{
            self.headers = headers
            return self
        }
        
        func withBody(_ body: [String: String]) -> Builder{
            self.body = body
            return self
        }
        
        func withInput(_ decodeType: T.Type) -> Builder{
            self.input = decodeType
            return self
        }
        
        func withOutput(_ dataToPost: String) -> Builder{
            self.output = dataToPost
            return self
        }
        
        func build() -> HTTPRequestClient{
            return HTTPRequestClient(self)
        }
    }
    
    
    private func makeRequest(completion: @escaping (T?) -> Void){
        let url = URL(string: self.builder.url!)
        guard let requestUrl = url else{
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = self.builder.method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !self.builder.body.isEmpty{
            if let jsonData = try? JSONSerialization.data(withJSONObject: self.builder.body){
                request.httpBody = jsonData
            }
        }
        
        for entry in self.builder.headers{
            request.setValue(entry.value, forHTTPHeaderField: entry.key)
        }
        
        if let dataToPost = self.builder.output{
            request.httpBody = dataToPost.data(using: String.Encoding.utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            if let data = data, let responseType = self.builder.input, responseType != BlankCodable.self{
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(responseType, from: data)
                    completion(result)
                }
                catch{
                    completion(nil)
                }
            }
            else{
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    func executeRequest(){
        self.queue.async {
            self.makeRequest(completion: {_ in })
        }
    }
    
    func executeAndGetResult(completion: @escaping (T?) -> Void){
        self.queue.async {
            self.makeRequest(completion: completion)
        }
    }
    
    func executeAndGetResultInOuterQueue(completion: @escaping(T?) -> Void){
        self.makeRequest(completion: completion)
    }
    
    func executeAndReturnSynchronousResult() -> T?{
        var result: T? = nil
    
        let group = DispatchGroup()
        self.queue.sync(){
            group.enter()
            self.makeRequest{ data in
                result = data
                group.leave()
            }
        }
            
        group.wait()
        return result
    }
}
