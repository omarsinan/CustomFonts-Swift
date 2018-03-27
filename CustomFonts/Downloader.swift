//
//  Downloader.swift
//  CustomFonts
//
//  Originally created by Trum Gyorgy on 12/1/15.
//  Modified for Swift 4 by Omar Sinan on 27/3/18.
//  Copyright (c) 2015 General Electric. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText
import UIKit

class Downloader {
    class func load(URL: NSURL , completion: @escaping () -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL as URL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {data,response,error in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                
                // This is your file-variable:
                // data
                
                var uiFont : UIFont?
                let fontData = data
                
                let dataProvider = CGDataProvider(data: fontData as! CFData)
                let cgFont = CGFont(dataProvider!)
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(cgFont!, &error)
                {
                    print("Error loading Font!")
                } else {
                    let fontName = cgFont?.postScriptName
                    uiFont = UIFont(name: String(describing: fontName) , size: 30)
                    completion()
                }
                
            } else {
                // Failure
                print("Faulure: %@", error?.localizedDescription);
            }
        }
        task.resume()
    }
}
