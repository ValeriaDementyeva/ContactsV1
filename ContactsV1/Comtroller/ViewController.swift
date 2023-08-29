//
//  ViewController.swift
//  ContactsV1
//
//  Created by Валерия Дементьева on 27.08.2023.
//

import UIKit

class ViewController: UIViewController {
    //свяжем сцену и созданную модель Contact. Свойство contacts – это массив контактов, элементы которого будут выведены в табличном представлении. При загрузке сцены данное свойство будет наполняться данными, а впоследствии использоваться для наполнения ячеек таблицы данными.
    var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort{ $0.name < $1.name
            }
            // сохранение контактов в хранилище
            storage.save(contacts: contacts)
        }
    }

    var storage: ContactStorageProtocol!
    
    @IBOutlet var tableView: UITableView!
    @IBAction func showNewContactAlert() {
        // создание Alert Controller
        let alertController = UIAlertController(title: "Создайте новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
        // добавляем первое текстовое поле в Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
        }
        // добавляем второе текстовое поле в Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Номер телефона"
        }

        // создаем кнопки
        // кнопка создания контакта
        let createButton = UIAlertAction(title: "Создать", style: .default) { [self] _ in
            guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else {
                return
            }
            // создаем новый контакт
            // Проверка валидности номера телефона
            if isValidPhoneNumber(phoneNumber: contactPhone) {
                // создаем новый контакт
                let contact = Contact(name: contactName, phone: contactPhone)
                self.contacts.append(contact)
                tableView.reloadData()
            } else {
                // Вывод сообщения об ошибке невалидного номера телефона
                let errorAlert = UIAlertController(title: "Ошибка", message: "Введите корректный номер телефона", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                errorAlert.addAction(okAction)
                present(errorAlert, animated: true, completion: nil)
            }
        }

        // кнопка отмены
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        // добавляем кнопки в Alert Controller
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        // отображаем Alert Controller
        present(alertController, animated: true, completion: nil)

        //Функция для проверки валидности номера телефона
        func isValidPhoneNumber(phoneNumber: String) -> Bool {
            let digitWithPlusPattern = "^[+]?[0-9]{11}$"
            let regex = try? NSRegularExpression(pattern: digitWithPlusPattern)
            let matches = regex?.numberOfMatches(in: phoneNumber, range: NSRange(location: 0, length: phoneNumber.utf16.count))
            return matches == 1
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = ContactStorage()
        loadContacts()

        // Do any additional setup after loading the view.
    }

    private func loadContacts() {
        contacts = storage.load()
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        версия 1
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .value1, reuseIdentifier: "MyCell")
        }
        configure(cell: cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].name
        configuration.secondaryText = contacts[indexPath.row].phone
        configuration.image = UIImage(systemName: contacts[indexPath.row].image)
        cell.contentConfiguration = configuration
    }
}
//    версия 2
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // производим попытку загрузки переиспользуемой ячейки
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
//        else {
//            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
//            let newCell = UITableViewCell(style: .value1, reuseIdentifier: "MyCell")
//            configure(cell: newCell, for: indexPath)
//            return newCell
//        }
//        print("Используем старую ячейку для строки с индексом \(indexPath.row)")
//        configure(cell: cell, for: indexPath)
//        return cell
//    }

//версия 3
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         // производим попытку загрузки переиспользуемой ячейки
//         if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
//             print("Используем старую ячейку для строки с индексом \(indexPath.row)")
//             configure(cell: cell, for: indexPath)
//             return cell
//         } else {
//             print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
//             let newCell = UITableViewCell(style: .value1, reuseIdentifier: "MyCell")
//             configure(cell: newCell, for: indexPath)
//             return newCell
//         }
//     }


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // действие удаления
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in
            // удаляем контакт
            self.contacts.remove(at: indexPath.row)
            print("Ячейка \(indexPath.row) удалена)")
            // заново формируем табличное представление
            tableView.reloadData()
        }
        let actionEdit = UIContextualAction(style: .normal, title: "Изменить") { _,_,_ in
            // Изменяем контакт
            self.contacts[indexPath.row].name = "Неизвестный контакт"
            self.contacts[indexPath.row].phone = "+7 (   ) (   ) ( ) ( )"
            print("Ячейка \(indexPath.row) изменена")
            // заново формируем табличное представление
            tableView.reloadData()
        }
        // формируем экземпляр, описывающий доступные действия
        let actions = UISwipeActionsConfiguration(actions: [actionDelete, actionEdit])
        return actions

    }
}


