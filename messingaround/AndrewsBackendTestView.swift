//
//  AndrewsBackendTestView.swift
//  messingaround
//
//  Created by Andrew Caravaggio on 2023-02-09.
//

import SwiftUI
import PythonKit

struct AndrewsBackendTestView: View {
    @State private var showResult: Bool = false
    var body: some View {
        let client_id = "daf925983160411786bc9afd3c8db891"
        let client_secret = "2be54995915c4bd197d6d85650faf39d"
        let redirect_uri = "spotify-api-example-app%3A%2F%2F"
        let code =
        "AQAc2omAgeOyoeNmTuUwf0GYjYPulRiifo4yQwWcNVZpFD83krsdhZm6iKW7fMrGZA1LW8hf19j995abYXdtHStqX5vVgng3OOnPIVQD0nCirQEUAlgk0j7SszTw4N_OWe-FkLJWN51YdVdd8n44DscrjjUb6Dge2ttrkhDk2_Wc7vt06qRRJXFn0Gx8TiPHxxuSRy0pyiaDefWtkzrB5dRm&state=pLQ0HSY5AniMH9Wd"
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
        NavigationView{
            VStack{
            Button(action:{
                
                
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
                        print(responseString)
                    }
                }


                showResult.toggle()
            },
                   label:{
                Text("My Button")
            })
    
    
        }
        }}
}

extension String {
    func markdownToAttributed() -> AttributedString {
        do {
            return try AttributedString(markdown: self) /// convert to AttributedString
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
}
