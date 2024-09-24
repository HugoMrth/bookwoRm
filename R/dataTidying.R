tidyBooks <- function(data) {
  # data <- openxlsx::read.xlsx("data/Livres.xlsx")

  colnames(data) <- c("id", "readDate", "theme", "formatl", "origin_niv1",
                       "title", "author", "pubDate",
                       "genre_niv1", "genre_niv2", "genre_niv3", "n_pages", "lang",
                       "CNL", "ML", "MF", "GR", "BR", "BI", "prix",
                       "note", "genre_detail", "comm")

  data <- data %>%
    dplyr::select(-theme, -comm) %>%
    mutate(
      readDate = as.Date(readDate, origin = "1899-12-30"),
      formatl = relevel_factor(formatl, new.levels = list("Physique" = "Physical", "Epub" = "Epub")),
      origin_group = relevel_factor(origin_niv1, new.levels = list(
        "Amazon" = "Online Bookstore",
        "Anna's Archive" = "Web Scraping",
        "Arnaud" = "Friends & Family",
        "Bibliothèque" = "Library",
        "Enfance" = "Friends & Family",
        "epubBooks" = "Web Scraping",
        "Fnac" = "Offline Bookstore",
        "Gutenberg" = "Web Scraping",
        "Internet" = "Web Scraping",
        "Librairie" = "Offline Bookstore",
        "Liliane" = "Friends & Family",
        "Maman" = "Mom",
        "Papa" = "Dad",
        "Papou & Mamoune" = "Friends & Family",
        "Recyclerie" = "Offline Bookstore"
      )),
      origin_niv1 = relevel_factor(origin_niv1, new.levels = list(
        "Amazon" = "Amazon",
        "Anna's Archive" = "Anna's Archive",
        "Arnaud" = "Arnaud",
        "Bibliothèque" = "Library",
        "Enfance" = "Already Owned",
        "epubBooks" = "epubBooks",
        "Fnac" = "Fnac",
        "Gutenberg" = "Gutenberg",
        "Internet" = "Internet",
        "Librairie" = "Bookstore",
        "Liliane" = "Liliane",
        "Maman" = "Mom",
        "Papa" = "Dad",
        "Papou & Mamoune" = "Grandparents",
        "Recyclerie" = "Recycling Bookstore"
      )),
      genre_niv1 = as.character(relevel_factor(genre_niv1, new.levels = list(
        "Epistolaire" = "Letters",
        "Graphique" = "Graphic",
        "Non Fiction" = "Non Fiction",
        "Poétique" = "Poetic",
        "Romanesque" = "Novels",
        "Théâtral" = "Theatre"
      ))),
      genre_niv2_group = as.character(relevel_factor(genre_niv2, new.levels = list(
        "Lettres" = "Letters",
        "Bande Déssinée" = "Comics",
        "Roman Graphique" = "Graphic Novels",
        "Album" = "Albums",
        "Poème" = "Poems",
        "Recueil de poèmes" = "Poems",
        "Conte" = "Tales",
        "Recueil de contes" = "Tales",
        "Nouvelle" = "Short stories",
        "Recueil de nouvelles" = "Short stories",
        "Recueil de séances" = "Short stories",
        "Roman" = "Novels",
        "Roman Court" = "Novels",
        "Poème Epique" = "Epics",
        "Epopée" = "Epics",
        "Comédie" = "Comedies",
        "Comédie grecque" = "Comedies",
        "Tragédie" = "Tragedies",
        "Tragédie grecque" = "Tragedies",
        "Drame" = "Dramas",
        "Discours & Plaidoyer" = "Speech, pamphlets...",
        "Pamphlet & Satire" = "Speech, pamphlets...",
        "Autobiographie" = "Biographies & Autobiographies",
        "Biographie" = "Biographies & Autobiographies",
        "Livre de Référence" = "Reference, treaties...",
        "Traité" = "Reference, treaties...",
        "Essai" = "Essay",
        "Dialogue" = "Essay",
        "Pensées" = "Essay"
      ))),
      genre_niv2_group = ifelse(is.na(genre_niv2_group), genre_niv2, genre_niv2_group),
      genre_niv2 = as.character(relevel_factor(genre_niv2, new.levels = list(
        "Lettres" = "Letters",
        "Bande Déssinée" = "Comics",
        "Roman Graphique" = "Graphic Novels",
        "Album" = "Albums",
        "Poème" = "Poems",
        "Recueil de poèmes" = "Collection of poems",
        "Conte" = "Tales",
        "Recueil de contes" = "Collection of tales",
        "Nouvelle" = "Short stories",
        "Recueil de nouvelles" = "Collection of short stories",
        "Recueil de séances" = "Collection of sessions",
        "Roman" = "Novels",
        "Roman Court" = "Short novels",
        "Poème Epique" = "Epics",
        "Epopée" = "Epics",
        "Comédie" = "Comedies",
        "Comédie grecque" = "Greek comedies",
        "Tragédie" = "Tragedies",
        "Tragédie grecque" = "Greek tragedies",
        "Drame" = "Dramas",
        "Discours & Plaidoyer" = "Speech & Advocacies",
        "Pamphlet & Satire" = "Satire & Pamphlets",
        "Autobiographie" = "Autobiographies",
        "Biographie" = "Biographies",
        "Livre de Référence" = "Reference books",
        "Traité" = "Treaties",
        "Essai" = "Essay",
        "Dialogue" = "Dialogues",
        "Pensées" = "Thoughts"
      ))),
      genre_niv3 = as.character(relevel_factor(genre_niv3, new.levels = list(
        "Allégorique" = "Allegorical",
        "Anticipation" = "Soft Science Fiction",
        "Apprentissage" = "Bildungroman",
        "Art" = "Art",
        "Autobiographie" = "Autobiography",
        "Autobiographique" = "Autobiographical",
        "Aventure" = "Adventure",
        "Biographie" = "Biography",
        "Biologie" = "Biology",
        "Chevaleresque" = "",
        "Dark Fantasy" = "Dark Fantasy",
        "Drame" = "Drama",
        "Dystopie" = "Dystopia",
        "Fantastique" = "Fantastic",
        "Fantasy" = "Fantasy",
        "Fiction Historique" = "Historical Fiction",
        "Guerre" = "War",
        "Histoire" = "History",
        "Historique" = "Historical Fiction",
        "Horreur" = "Horror",
        "Humour" = "Humouristic",
        "Journal" = "Journal",
        "Littérature" = "Litterature",
        "Mathématiques" = "Maths & Stats",
        "Mémoires" = "Memories",
        "Moderniste" = "Modern",
        "Mythologique" = "Mythology",
        "Naturaliste" = "Naturalist",
        "Philosophie" = "Philosophy",
        "Philosophique" = "Philosophical",
        "Poétique" = "Poetic",
        "Policier" = "Crime",
        "Politique" = "Politics",
        "Post Apocaliptique" = "Post-Apocalyptic",
        "Psychologie" = "Psychology",
        "Psychologique" = "Psychological",
        "Réalisme Magique" = "Magic Realism",
        "Réaliste" = "Realistic",
        "Religion" = "Religions",
        "Roman Noir" = "Dark",
        "Romance" = "Romance",
        "Saga Familiale" = "Family Saga",
        "Satirique" = "Satirical",
        "Science Fiction" = "Science Fiction",
        "Sociologie" = "Sociology",
        "South Gothic" = "South Gothic",
        "Statistiques" = "Maths & Stats",
        "Thriller" = "Thriller",
        "Tragédie" = "Tragedy"
      ))),
      lang = relevel_factor(lang, new.levels = list("Français" = "French", "Anglais" = "English")),
      note = as.numeric(note)
      )
}



tidyWishlist <- function(wishlist) {
  wishlist <- wishlist[, c(1, 3:6)]
  colnames(wishlist) <- c("State", "Title", "Author", "Genre", "Sub-Genre")
  whishlist <- wishlist %>%
    mutate(
      State = as.character(relevel_factor(State, new.levels = list(
        "A Relire" = "To Read Again",
        "Dispo Epub" = "Available (epub)",
        "Disponible" = "Available (physical)",
        "Idée" = "Idea"
      ))),
      Genre = as.character(relevel_factor(Genre, new.levels = list(
        "Epistolaire" = "Letters",
        "Graphique" = "Graphic",
        "Non Fiction" = "Non Fiction",
        "Poésie" = "Poetic",
        "Romanesque" = "Novels",
        "Roman" = "Novels",
        "Théâtral" = "Theatre",
        "Mythologie" = "Mythology"
      ))),
      `Sub-Genre` = as.character(relevel_factor(`Sub-Genre`, new.levels = list(
        "Biographie" = "Biography",
        "Développement Personnel" = "Self Help",
        "Essai" = "Essay",
        "Histoire" = "History",
        "Mythologie" = "Mythology",
        "Pensées" = "Thoughts",
        "Philosophie" = "Philosophy",
        "Politique" = "Politics",
        "Roman" = "Novel",
        "Sciences" = "Sciences",
        "Théâtral" = "Theatre",
        "Traité" = "Treaty"
      )))
    )

  }


tidyQuotes <- function(quotes) {
  quotes <- quotes[, c(1, 4, 6, 7)]
  colnames(quotes) <- c("Author", "Theme", "Ranking", "Quote")

  quotes$Theme <- as.character(relevel_factor(quotes$Theme, new.levels = list(
    "Amour" = "Love",
    "Anarchisme" = "Politics",
    "Art" = "Art",
    "Economie" = "Economy",
    "Histoire" = "History",
    "Humain" = "Humanity",
    "Humour" = "Humor",
    "Justice & Politique" = "Politics",
    "Maths & Stats" = "Science",
    "Morale & Ethique" = "Ethics",
    "Musique" = "Art",
    "Philosophie" = "Philosophy",
    "Politique" = "Politics",
    "Prose" = "Prose",
    "Prose (poésie)" = "Prose",
    "Psychologie" = "Psychology",
    "Religion" = "Religion",
    "Solitude" = "Loneliness",
    "Temps" = "Humanity",
    "Vie & Mort" = "Life & Death"
  )))

  quotes$Ranking <- as.character(relevel_factor(quotes$Ranking, new.levels = list(
    "o" = "O",
    "O" = "O",
    "0" = "O",
    "x" = "X",
    "X" = "X"
  )))

  quotes
}
