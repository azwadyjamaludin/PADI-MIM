//
//  FileUtils.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 17/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import Foundation
import FileKit

class FileUtils {
    internal static func tempDirectory() throws -> Path {
        return try self.directoryInsideDocumentsWithName(name: "temp")
    }
    
    internal static func directoryInsideDocumentsWithName(name: String, create: Bool = true) throws -> Path {
        let directory = Path(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]) + name
        if create && !directory.exists {
            try directory.createDirectory()
        }
        return directory
    }
}
