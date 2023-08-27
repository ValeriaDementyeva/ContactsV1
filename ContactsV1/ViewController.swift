//
//  ViewController.swift
//  ContactsV1
//
//  Created by Валерия Дементьева on 27.08.2023.
//

import UIKit

class ViewController: UIViewController {
//свяжем сцену и созданную модель Contact. Свойство contacts – это массив контактов, элементы которого будут выведены в табличном представлении. При загрузке сцены данное свойство будет наполняться данными, а впоследствии использоваться для наполнения ячеек таблицы данными.
    private var contacts = Contact.info

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//

