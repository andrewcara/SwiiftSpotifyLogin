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
        NavigationView{
            VStack{
            Button(action:{
                let _ = login()

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
