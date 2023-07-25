//
//  WidgetHandler.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import Foundation
import Combine
import TerraiOS
import AuthenticationServices

struct TerraWidgetSessionCreateResponse:Decodable{
    var status: String = String()
    var url: String = String()
    var session_id: String = String()
}

struct TerraAuthToken :Decodable{
    var status: String = String()
    var token: String = String()
}



class WidgetHandler: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding{
    
    var subscriptions = Set<AnyCancellable>()
    
    static func getSessionUrl() -> String?{
        let widgetSessionUrl = URL(string: "https://api.tryterra.co/v2/auth/generateWidgetSession")
        var sessionUrl: String? = nil
        var request = URLRequest(url: widgetSessionUrl!)
        let requestData = ["reference_id": "User", "language": "EN", "auth_success_redirect_url": "terraficapp://"]
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "widget.Terra")
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(DEVID, forHTTPHeaderField: "dev-id")
        request.setValue(XAPIKEY, forHTTPHeaderField: "X-API-Key")
        
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(TerraWidgetSessionCreateResponse.self, from: data)
                    sessionUrl = result.url
                    group.leave()
                }
                catch{
                    print(error)
                }
            }
        }
        group.enter()
        queue.async(group:group) {
            task.resume()
        }
        group.wait()
        return sessionUrl
    }
    
    public static func generateAuthToken() -> String?{
        let authTokenUrl = URL(string: "https://api.tryterra.co/v2/auth/generateAuthToken")
        var token: String? = nil
        var request = URLRequest(url: authTokenUrl!)
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "widget.Terra")
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(DEVID, forHTTPHeaderField: "dev-id")
        request.setValue(XAPIKEY, forHTTPHeaderField: "X-API-Key")
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(TerraAuthToken.self, from: data)
                    token = result.token
                    group.leave()
                }
                catch{
                    print(error)
                }
            }
        }
        group.enter()
        queue.async(group:group) {
            task.resume()
        }
        group.wait()
        return token
    }


    
    func displayWidget(_ completion: @escaping(Bool, String?, String?) -> Void){
        let widgetSessionFuture = Future<URL, Error> {promise in
            guard let sessionUrl = WidgetHandler.getSessionUrl() else{
                promise(.failure(TerraficAppErrors.InvalidResponse))
                return
            }
            
            let authSession = ASWebAuthenticationSession(url: URL(string: sessionUrl)!, callbackURLScheme: "terrapp", completionHandler: { url, error in
                if let error = error{
                    promise(.failure(error))
                }
                else if let url = url {
                    promise(.success(url))
                }
            })
            
            authSession.prefersEphemeralWebBrowserSession = true
            authSession.presentationContextProvider = self
            authSession.start()
        }
        
        widgetSessionFuture.sink(receiveCompletion: { _completion in
            switch _completion{
            case .failure(_):
                print("Failed to generate auth url")
                completion(false, nil, nil)
            default: break
            }
        }) { url in
            self.processUrl(url, completion)
        }
        .store(in: &subscriptions)
    }
    
    private func processUrl(_ url: URL, _ completion: @escaping(Bool, String?, String?) -> Void){
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let queries = components?.queryItems, queries.filter({$0.name == "reason"}).isEmpty else{
            print("Auth failed reason \(String(describing: components?.queryItems?.filter({$0.name == "reason"})[safe:0]?.value))")
            completion(false, nil, nil)
            return
        }
        
        if queries.first(where: { queryItem in
            queryItem.name == "resource"
        })?.value == "APPLE"{
            ContentView.terraManager?.initConnection(type: .APPLE_HEALTH, token: WidgetHandler.generateAuthToken() ?? ""){success, error in
                if let error = error{
                    print(error)
                    completion(success, nil, nil)
                    return
                }
                completion(success, (ContentView.terraManager?.getUserId(type: .APPLE_HEALTH))!, "APPLE")
            }
            
        }
        
        else {
            completion(true, queries.filter({$0.name == "user_id"})[safe: 0]?.value, queries.filter({$0.name == "resource"})[safe: 0]?.value)
        }
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
}
