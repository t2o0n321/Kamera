//
//  fileHandler.swift
//  Kamera
//
//  Created by t2o0n321 on 2024/3/5.
//
import SwiftUI

class fileManager{
    private var sdbxDirPath: String?
    init(){
        let documentFolderPath = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let documentPath = NSSearchPathForDirectoriesInDomains(documentFolderPath, userDomainMask, true)
        self.sdbxDirPath = self.sdbxDirPath == nil ? documentPath[0] : ""
    }
    public func getSdbxDirPath() -> String {return self.sdbxDirPath!}
    public func genFileUrl() -> URL{
        var fileName: String = ""
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        fileName = dateFormatter.string(from: now).components(separatedBy: "(")[0]
        return URL(fileURLWithPath: "\(self.sdbxDirPath!)/\(fileName).png")
    }
}
