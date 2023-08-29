//
//  ContactStorage.swift
//  ContactsV1
//
//  Created by Валерия Дементьева on 29.08.2023.
//

import Foundation
import UIKit

protocol ContactStorageProtocol {
    // Загрузка списка контактов
    func load() -> [ContactProtocol]
    // Обновление списка контактов
    func save(contacts: [ContactProtocol])
}

class ContactStorage: ContactStorageProtocol {
    // Ссылка на хранилище
    private var storage = UserDefaults.standard
    // Ключ, по которому будет происходить сохранение хранилища
    private var storageKey = "contacts"

    // Перечисление с ключами для записи в User Defaults
    private enum ContactKey: String {
        case name
        case phone
        case image
    }
    func load() -> [ContactProtocol] {
        var resultContacts: [ContactProtocol] = []
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for contact in contactsFromStorage {
            guard let name = contact[ContactKey.name.rawValue], let phone = contact[ContactKey.phone.rawValue], let image = contact[ContactKey.image.rawValue] else {
                continue
            }
            resultContacts.append(Contact(name: name, phone: phone, image: image))
        }
        return resultContacts
    }

    func save(contacts: [ContactProtocol]) {
        var arrayForStorage: [[String:String]] = []
        contacts.forEach { contact in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[ContactKey.name.rawValue] = contact.name
            newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            newElementForStorage[ContactKey.image.rawValue] = contact.image
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}

