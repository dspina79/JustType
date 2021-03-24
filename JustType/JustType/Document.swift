//
//  Document.swift
//  JustType
//
//  Created by Dave Spina on 3/23/21.
//

import UIKit

enum FileError: Error {
    case invalidData
}

class Document: UIDocument {
    var text = "" // my text value
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data(text.utf8)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let contents = contents as? Data else {
            throw FileError.invalidData
        }
        
        text = String(decoding: contents, as: UTF8.self)
    }
}

