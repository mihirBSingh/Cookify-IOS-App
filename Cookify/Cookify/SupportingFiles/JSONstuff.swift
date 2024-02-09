//
//  convertJSON.swift
//  Cookify
//
//  Created by jake gilbert on 11/27/23.
//

import Foundation

class getJSON {
    func convertJSON(forName name: String) -> Data {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json"){
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                return data
            }
        } catch {
            print("ERROR")
        }
        return Data()
    }
}

