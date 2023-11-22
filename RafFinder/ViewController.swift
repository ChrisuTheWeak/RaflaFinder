//
//  ViewController.swift
//  RafFinder
//
//  Created by iosdev on 21.11.2023.
//

import UIKit
import SwiftUI


/*struct ViewController: View {
    
}

struct ViewController_Previews: PreviewProvider{
    static var previews: some View {
        ViewController()
    }
}*/


class ViewController: UIViewController {
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RaflaFinder"
        
        button.setTitle("Go", for: .normal)
        view.addSubview(button)
        
    }
}




/*
struct ViewController: View {
    let navigationItems = {
        NavigationItem(name: "a", views: .first)
        NavigationItem(name: "b", views: .map)
        NavigationItem(name: "c", views: .menu)
    }
    var body: some View {
        NavigationStack{
            List(navigationItems, id: \.self) { item in NavigationLink(item.name, value: item)
            }
            .navigationDestination(for: NavigationItem.self, destination: { item in
                switch item.views{
                case .first:
                    FrontView()
                case .map:
                    RestaurantView()
                case .menu:
                    Menu()
                }
            })
        }
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}

struct NavigationItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var views: Views
}

enum Views: String {
    case first
    case map
    case menu
}
*/
