//
//  ContentView.swift
//  DeepLink
//
//  Created by Son, Nguyen Hoang on 1/22/21.
//

import SwiftUI
import Combine
struct Result: Decodable {
    let rate: String
}


struct TaskEntry: Codable  {
    let id: Int
    let title: String
}

struct ContentView: View {
    @State var result : Result? = nil
    
    //Since the response is an array of TaskEntry object
    @State var results = [TaskEntry]()
    
    
    @State var trigger : Bool = false
    
    var body: some View {
        
        List {
            Button(action: open, label: {
                Text("OpenOurApp")
            })
            
            Button(action: openFB, label: {
                Text("OpenFB")
            })
            
            Button(action: openZalo, label: {
                Text("OpenZalo")
            })
            
            Button(action: openTeam, label: {
                Text("OpenTeams")
            })
            
            Button(action: openWhatsapp, label: {
                Text("OpenWhatsapp")
            })
            
        }
        
    }
    
    private func open(){
        loadData(customUrl: "ios-assign3-rmit://Hello")
        //let url = URL(string: urlstr)
    }
    
    private func openFB(){
        let str : String = "fb-messenger://"
        UIApplication.shared.open(URL(string: str)!) { (result) in
            if result {
               // The URL was delivered successfully!
            }
        }
    }
    
    private func openZalo(){
        loadData(customUrl: "https://zalo.me/")
        //let url = URL(string: urlstr)
    }
    
    private func openTeam(){
        loadData(customUrl: "msteams://")
        //let url = URL(string: urlstr)
    }
    
    private func openWhatsapp(){
        loadData(customUrl: "whatsapp://")
        //let url = URL(string: urlstr)
    }
    
    
    
    func loadData(customUrl : String) {
        
        //print("RUNNING")
        guard let url = URL(string: "http://tinyurl.com/api-create.php?url=" + customUrl) else {
          //  print("Invalid URL")
            return
        }
        //print("HI THERE")
        let request = URLRequest(url: url)
        var str : String = ""
        URLSession.shared.dataTask(with: request) { data, response, error in
            str  = String(data: data!, encoding: String.Encoding.utf8)!
//            return str
            print("DATAAAAAAAA")
            print(str)
            
            DispatchQueue.main.async {
                UIApplication.shared.open(URL(string: str)!) { (result) in
                    if result {
                       // The URL was delivered successfully!
                    }
                }
            }
        }.resume()
        
        
        
    }
    
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
