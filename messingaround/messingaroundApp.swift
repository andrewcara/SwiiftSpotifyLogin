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


struct messingaroundApp: App {
    var body: some Scene {
        WindowGroup {
            AndrewsBackendTestView().onOpenURL { (url) in
                        print(url)
                }
        }
    }
}



//    .onOpenURL { (url) in
//        print(url)
//}
