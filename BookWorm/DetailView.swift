//
//  DetailView.swift
//  BookWorm
//
//  Created by Matteo on 06/07/2021.
//

import CoreData
import SwiftUI

struct DetailView: View {
    
    let book: Book
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Poetry")
                        .frame(maxWidth: proxy.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "POETRY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                    
                }
                
                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No Review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.title)
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "The Sword of Shannara"
        book.author = "Terry Brooks"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "A great adventure!"
        
        return NavigationView {
            DetailView(book: book)
        }
        
        
    }
}
