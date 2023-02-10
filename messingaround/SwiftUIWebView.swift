//
//  AndrewsBackendTestView.swift
//  messingaround
//
//  Created by Andrew Caravaggio on 2023-02-03.
//

import Foundation

//we get the access code from the onOpenURl

//format of the url is potify-api-example-app://?code=AQCulwXMtfa1NLv1cRwiea133eSjPrB-MledfVr5cmqcH0II54iWadHIX_CSE7ExAw32Bf26TqpZs_AhBHpE-gE3C41K12x2Eb9s-UVOCvCLX8A50PvsdJhmmdy5RCiEsvY_VCvfLxM3N3QjEL8OKLXzxkyPsXW3xSNOOqD7-uT_mFQEL4zbjJRXtMdVjDs2R8raDBpQ&state=yu6qfBs3n4aRXpy3
//we need everything after code= to make the next request for tokens

func callbac(accessCode: String) {
    
    let client_id = "daf925983160411786bc9afd3c8db891"
    let client_secret = "2be54995915c4bd197d6d85650faf39d"
    let redirect_uri = "spotify-api-example-app%3A%2F%2F"
    let code = accessCode
    let authOptions: [String: Any] = [
        "form": [
            "grant_type": "authorization_code",
            "redirect_uri": redirect_uri,
            "code": code,
        ],
        "headers": [
            "Authorization": "Basic "
            + (Data("\(client_id):\(client_secret)".utf8).base64EncodedString())
        ],
        "json": true,
    ]
    
    sendPostRequest(options: authOptions) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            print("Error: No data or response")
            return
        }
        
        if response.statusCode != 200 {
            print("Error: Response code is not 200")
            return
        }
        
        if let json = true as? Bool, json == true {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObject)
            } catch {
                print("Error: Unable to parse JSON")
            }
        } else {
            let responseString = String(data: data, encoding: .utf8)
            print(responseString) //this prints the access token information
        }
    }
}

//this function is just a bunch of formatting bs for the post request to the api/token endpoint
func sendPostRequest(options: [String: Any], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let endpoint = "https://accounts.spotify.com/api/token"
    guard let endpointUrl = URL(string: endpoint) else {
        completion(nil, nil, NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid endpoint URL"]))
        return
    }
    
    var request = URLRequest(url: endpointUrl)
    request.httpMethod = "POST"
    
    if let headers = options["headers"] as? [String: String] {
        for (headerField, headerValue) in headers {
            request.setValue(headerValue, forHTTPHeaderField: headerField)
        }
    }
    
    if let form = options["form"] as? [String: String] {
        let formData = form.map { "\($0)=\($1)" }.joined(separator: "&").data(using: .utf8)
        request.httpBody = formData
    }
    
    URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
}


    func login(){
        
        let state = randomString(length: 16)
        let redirect = "spotify-api-example-app%3A%2F%2F"
        let url =  URL(string:"https://accounts.spotify.com/en/authorize?client_id=daf925983160411786bc9afd3c8db891&response_type=code&redirect_uri="+redirect+"&scope=playlist-modify-public&show_dialog=True&state="+state)!
        //print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(url)
        
        //This just checks that the url is valid
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard data != nil else { return }
            //print(String(data: data!, encoding: .utf8)!)
        }
        
        
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    extension String {
        
        func fromBase64() -> String? {
            guard let data = Data(base64Encoded: self) else {
                return nil
            }
            
            return String(data: data, encoding: .utf8)
        }
        
        func toBase64() -> String {
            return Data(self.utf8).base64EncodedString()
        }
    }
    
    

