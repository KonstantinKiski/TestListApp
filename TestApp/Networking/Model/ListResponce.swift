//
//  ListResponce.swift
//  TestApp
//
//  Created by Константин Киски on 14.07.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

struct Variants: Codable, Equatable {
    var id: Int?
    var text: String?
    
    static func ==(first: Variants, second: Variants) -> Bool {
        return first.id == second.id
    }
}

struct Additionals: Codable {
    var text: String?
    var url: String?
    var variants: [Variants]?
}

struct ListResponce: Codable {
    
    var name: String?
    var additions: Additionals?
    

    private enum CodingKeys: String, CodingKey {
        case name, additions = "data"
    }
     
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        self.additions = try? container.decode(Additionals.self, forKey: .additions)
    }
}

class MainData: Codable {
    
    var list: [ListResponce]?
    var view: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case list = "data", view
    }
     
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try? container.decode([ListResponce].self, forKey: .list)
        self.view = try? container.decode([String].self, forKey: .view)
    }
}
