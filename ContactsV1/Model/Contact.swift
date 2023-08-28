//
//  Contact.swift
//  ContactsV1
//
//  Created by Валерия Дементьева on 27.08.2023.
//

import Foundation
import UIKit

protocol ContactProtocol {
    // Имя
    var name: String { get set }
    // Номер телефона
    var phone: String { get set }
    // Изображение
    var image: String { get set }
    
}

struct Contact: ContactProtocol {
    var name: String
    var phone: String
    var image: String = "person"

}

extension Contact {
    static let info = [
        Contact(name: "Vasya 1", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 2", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 3", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 4", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 5", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 6", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 7", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 8", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 9", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 10", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 11", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 12", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 13", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 14", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 15", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 16", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 17", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 18", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 19", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 20", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 21", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 22", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 23", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 24", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 25", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 26", phone: "+7 987 987 87 76"),
        Contact(name: "Vasya 27", phone: "+7 987 987 87 76")
    ]
}
