// https://raw.githubusercontent.com/vapor-community/vapor-ext/master/Sources/ServiceExt/Environment%2BDotEnv.swift
//
//  Environment+DotEnv.swift
//  ServiceExt
//
//  Created by Gustavo Perdomo on 07/28/18.
//  Copyright © 2018 Vapor Community. All rights reserved.
//

import Service

public extension Environment {
    var shortname: String {
        switch self {
        case .production: return "prod"
        case .development: return "dev"
        case .testing: return "test"
        default: return self.name
        }
    }

    var shortfilename: String { return ".\(shortname).env" }

    func loadFile() {
        ((Environment.loadFile(".env")
            .flatMap {
                base in Environment.loadFile(shortfilename).flatMap { base + $0 }

            }) ?? Environment.loadFile(shortfilename))
            .flatMap { Environment.parse(fileContent: $0) }
            .flatMap { $0.forEach { (key, value) in setenv(key, value, 0) } }
    }

    /// Loads environment variables from .env files.
    ///
    /// - Parameter filename: name of your env file.
    static func dotenv(filename: String = ".env") {
        loadFile(filename)
            .flatMap { parse(fileContent: $0) }
            .flatMap { $0.forEach { (key, value) in setenv(key, value, 0) } }
    }

    private static func loadFile(_ filename: String) -> String? {
        guard
            let path = getAbsolutePath(for: filename),
            let contents = try? String(contentsOfFile: path, encoding: .utf8) else {
                return nil
        }

        return contents
    }

    private static func parse(fileContent: String) -> [String : String] {
        let contentArray: [(String, String)] = fileContent.split(whereSeparator: { $0 == "\n" || $0 == "\r\n" })
            .compactMap { line in
                if line.starts(with: "#") {
                    return nil
                }

                // ignore lines that appear empty
                if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return nil
                }

                // extract key and value which are separated by an equals sign
                let parts = line.components(separatedBy: "=")

                let key = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
                var value = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)

                // remove surrounding quotes from value & convert remove escape character before any embedded quotes
                if value[value.startIndex] == "\"" && value[value.index(before: value.endIndex)] == "\"" {
                    value.remove(at: value.startIndex)
                    value.remove(at: value.index(before: value.endIndex))
                    value = value.replacingOccurrences(of: "\\\"", with: "\"")
                }

                // remove surrounding single quotes from value & convert remove escape character before any embedded quotes
                if value[value.startIndex] == "'" && value[value.index(before: value.endIndex)] == "'" {
                    value.remove(at: value.startIndex)
                    value.remove(at: value.index(before: value.endIndex))
                    value = value.replacingOccurrences(of: "'", with: "'")
                }

                return (key, value)
            }

        return .init(contentArray, uniquingKeysWith: { _, last in last })
    }

    /// Determine absolute path of the given argument relative to the current directory.
    ///
    /// - Parameter relativePath: relative path of the file.
    /// - Returns: the absolute path if exists.
    private static func getAbsolutePath(for filename: String) -> String? {
        let fileManager = FileManager.default
        let currentPath = DirectoryConfig.detect().workDir.finished(with: "/")
        let filePath = currentPath + filename
        if fileManager.fileExists(atPath: filePath) {
            return filePath
        } else {
            return nil
        }
    }
}
