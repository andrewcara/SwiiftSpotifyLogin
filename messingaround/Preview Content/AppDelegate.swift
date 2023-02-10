//
//  AppDelegate.swift
//  messingaround
//
//  Created by Andrew Caravaggio on 2023-02-10.
//

import SwiftUI

func application(_ application: NSApplicationDelegate,
                 open url: URL,
                 options: [launchIsDefaultUserInfoKey: Any] = [:] ) -> Bool {

    // Determine who sent the URL.
    let sendingAppID = options[.messingaround]
    print("source application = \(sendingAppID ?? "Unknown")")

    // Process the URL.
    guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
          let albumPath = components.path,
          let params = components.queryItems else {
        print("Invalid URL or album path missing")
        return false
    }
}
