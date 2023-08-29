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
