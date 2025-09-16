//
//  Extensions.swift
//  iostodoapp
//
//  Created by Utku Özer on 16.09.2025.
//

import Foundation

extension Decodable { // Codable direk olmuyor burada. = Decodable&Encodable!
    /// Data'yı decode edip model tipine dönüştürür
    static func fromJSON(_ data: Data) -> [ListItem]? { // ListItem listesi almamız gerkiyor.
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([ListItem].self, from: data) // byte halinde olan raw datayı built-in decode methoduyla ListItem listesine çevirdi.
        } catch {
            print("Decoding error:", error)
            return nil
        }
    }
}
