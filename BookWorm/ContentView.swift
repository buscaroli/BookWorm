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
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true),
        NSSortDescriptor(keyPath: \Book.rating, ascending:false)
    ])var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
   
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
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
