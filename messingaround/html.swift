//
//  html.swift
//  messingaround
//
//  Created by Andrew Caravaggio on 2023-02-09.
//
import SwiftUI
import WebKit

func html()->String{
    
    let htmlFile = Bundle.main.path(forResource:"view", ofType: "html")
    let htmlString = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
    print(htmlString)
    return(htmlString)!

}


