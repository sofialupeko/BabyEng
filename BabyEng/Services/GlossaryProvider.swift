//
//  GlossaryProvider.swift
//  BabyEng
//
//  Created by Denis Valshchikov on 20.10.2021.
//

import Foundation

final class GlossaryProvider {
    private static let names: [[String]] = [
        ["One glossary",        "hello", "hey"],
        ["Another glossary",    "goodbye", "bye"],
        ["One more glossary",   "how", "are", "you"]
    ]
    private static let flags: [Bool] = [
        false,
        false,
        false
    ]
    func getGlossariesList() -> GlossariesList {
        return GlossariesList(glossariesNames: Self.names, isOpen: Self.flags)
    }
}
