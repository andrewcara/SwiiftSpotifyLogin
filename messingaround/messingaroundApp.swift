//
//  messingaroundApp.swift
//  messingaround
//
//  Created by Andrew Caravaggio on 2023-02-03.
//

//
//  AutoSpotoApp.swift
//  AutoSpoto
//
//  Created by Martin Maly on 2022-09-03.
//

import SwiftUI

@main

        // Do the same handling than in .onOpenURL
struct messingaroundApp: App {
    var body: some Scene {
        WindowGroup {
            AndrewsBackendTestView()
                .onOpenURL { (url) in
                print(url)
                let components = url.absoluteString.components(separatedBy: "code=")
                //look at the top of the SwiftUiWebView for an explanation of this character stripping
                let lastPart = components.last!
                print(lastPart)
                callbac(accessCode: lastPart)
                            }
            }
    }
}



//    .onOpenURL { (url) in
//        print(url)
//}
