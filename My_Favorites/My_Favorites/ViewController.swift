//
//  ViewController.swift
//  My_Favorites
//
//  Created by Амина Мамырбекова on 11.11.2025.
//

import UIKit

struct FavoriteItem {
    let image: UIImage
    let title: String
    let subtitle: String
    let review: String
}

struct CategorySection{
    let name: String
    let items: [FavoriteItem]
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories: [CategorySection]=[
           CategorySection(
               name: "Favorite Movies",
               items: [
                FavoriteItem(image: UIImage(named: "hate")!, title: "10 Things I Hate About You", subtitle:"Teen Romantic Comedy, 1999" , review: "Beneath the comedy, the film deals with themes of feminism, social pressure."),
                   FavoriteItem(image: UIImage(named: "eatpraylove")!, title: "Eat, Pray, Love", subtitle:"Biographical Romantic Drama, 2010" , review: "Woman, who found the message of finding oneself."),
                   FavoriteItem(image: UIImage(named: "fastfurious")!, title: "Fast and Furious 5", subtitle:"Crime, Thriller, Car Action, 2011" , review: "The film delivers a massive dose of nostalgia by uniting everyone."),
                   FavoriteItem(image: UIImage(named: "hacksaw")!, title: "Hacksaw Ridge",subtitle: "Biographical War Drama, 2016", review:"Hacksaw Ridge is a visually stunning and emotionally powerful war film."),
                   FavoriteItem(image: UIImage(named: "pride")!, title: "Pride and Prejudice", subtitle:"Romantic Drama / Period Piece, 2005",review: "The major thing that i liked about this movie is the slow-burn realization of true love.")
                   
               ]
           ),
           CategorySection(
               name: "Favorite Books",
               items: [
                FavoriteItem(image: UIImage(named: "blackberry")!, title: "Blackberry Winter", subtitle: "Sarah Jio, 2012", review: " The novel is a beautiful exploration of motherhood, sacrifice, and the enduring bond between parent and child."),
                FavoriteItem(image: UIImage(named: "montekristo")!, title: "The Count Of Monte Cristo", subtitle: "Alexandre Dumas, 1844", review: "The book is good because it poses timeless questions: Can wealth truly buy justice? What is the limit of human suffering and endurance?"),
                FavoriteItem(image: UIImage(named: "violets")!, title: "The Violets of March", subtitle: "Sarah Jio, 2011", review: "Book makes you feel — there’s sadness, love, mystery, and healing all mixed together. The old diary adds a fun, secret puzzle that keeps readers turning the pages."),
                FavoriteItem(image: UIImage(named: "captain")!, title: "The Children of Captain Grant", subtitle: "Jules Verne, 1867", review: "The story is full of action, travel, and surprises, it kept me hooked. We get to travel around the world and learn about different lands, animals, and cultures."),
                FavoriteItem(image: UIImage(named: "mockingbird")!, title: "To Kill a Mockingbird", subtitle: "Harper Lee, 1960", review: "The book teaches about justice, equality, and standing up for what’s right. It reminded me to be kind, fair, and to “walk in someone else’s shoes.”")
                   ]
           ),
           CategorySection(
               name: "Favorite Albums",
               items: [
                FavoriteItem(image: UIImage(named: "tear")!, title: "Love Yourself: Tear", subtitle: "BTS, 2018", review: "BTS blends rap, vocals, and different genres in a smooth way. The songs makes all the listeners feel the highs and lows of love and self-growth."),
                FavoriteItem(image: UIImage(named: "taylor")!, title: "1989", subtitle: "Taylor Swift, 2014", review: "Every track is easy to sing along to and memorable. Perfect for dancing or feeling happy, with a few deeper songs for emotional moments."),
                FavoriteItem(image: UIImage(named: "layover")!, title: "Layover", subtitle: "Kim Taehyung(V), 2023", review: "The album creates a relaxing, introspective vibe — good for late nights, quiet drives, or just floating along with the music. Also I really enjoy V's baritone."),
                FavoriteItem(image: UIImage(named: "billie")!, title: "Hit Me Hard and Soft", subtitle: "Billie Eilish, 2024", review: "The album explores themes like maturity, love, heartbreak, and finding herself beyond the persona. But it's still pop‑accessible."),
                FavoriteItem(image: UIImage(named: "bruno")!, title: "24K Magic", subtitle: "Bruno Mars, 2016", review: "The songs make you want to dance or sing along. It’s inspired by 80s and 90s funk/R&B but still feels fresh."),
                   
               ]
           ),
           CategorySection(
               name: "Favorite Courses",
               items: [
                FavoriteItem(image: UIImage(named: "english")!, title: "English", subtitle: "The study of language, literature, and communication", review: "This course improves communication skills, sparks creativity, and opens the door to understanding different cultures and ideas."),
                FavoriteItem(image: UIImage(named: "algebra")!, title: "Linear Algebra", subtitle: "The study of vectors, matrices, and systems of equations.", review: "This course helps visualize mathematical concepts in a practical way. I learnes how to solve complex systems of equations."),
                FavoriteItem(image: UIImage(named: "oop")!, title: "Object-Oriented Programming (OOP)", subtitle: "Designing software using classes, objects, and reusable code.", review: "OOP teached me how to structure programs using objects and classes, making code easier to manage, reuse, and scale."),
                FavoriteItem(image: UIImage(named: "data")!, title: "Data Storage and Analysis", subtitle: "Organizing, managing, and interpreting data efficiently", review: "I gained critical skills for making data-driven decisions, helps understand patterns and trends."),
                FavoriteItem(image: UIImage(named: "ios")!, title: "iOS Development", subtitle: "Creating apps for iPhone, iPad, and other Apple devices", review: "I like it, because it lets me see how apps come to life."),
                   
               ]
           )
       ]
       override func viewDidLoad() {
           super.viewDidLoad()
           tableView.dataSource=self
           tableView.delegate=self
           
           tableView.rowHeight = UITableView.automaticDimension
           tableView.estimatedRowHeight = 200
       }
   }
       
   extension ViewController: UITableViewDataSource{
       func numberOfSections(in tableView: UITableView) -> Int {
           return categories.count
       }
       
       func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
           return categories[section].items.count // 5
       }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell=tableView.dequeueReusableCell(withIdentifier: "cell") as! FavoriteTableViewCell
               let currentItem=categories[indexPath.section].items[indexPath.row]
               cell.configure(with: currentItem)
               return cell
           }
           func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
               return categories[section].name
           }
           
       }

   extension ViewController: UITableViewDelegate{
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("indexPath: \(indexPath.section) | \(indexPath.row)")
       }
}

