//
//  ContentView.swift
//  BookWorm
//
//  Created by Matteo on 06/07/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [])var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
   
    var body: some View {
        NavigationView {
            Text("Count: \(books.count)")
                .navigationBarTitle("BookWorm")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.showingAddScreen.toggle()
                                        }) {
                                            Image(systemName: "plus")
                                        }
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
