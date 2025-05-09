# article_hub


A Flutter app that fetches and displays a list of articles from a public API, with search and favorite functionality, using Riverpod for state management and Hive for local persistence.

---

## ✨ Features

- Fetch and display a list of articles
- Search articles by title
- Mark/unmark articles as favorites
- View article details
- Responsive UI for different screen sizes
- Local persistence of favorite articles using Hive

---

## 🚀 Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/shamsheersha/article_hub.git
   cd article_hub

   🛠️ Tech Stack
Flutter SDK: 3.x.x

State Management: Riverpod

HTTP Client: HTTP package (http)

Persistence: Hive (for local storage of favorites)

🔥 State Management Explanation
Riverpod is used for managing the application's state.
The ArticleController (a StateNotifier) handles fetching articles, searching, and managing favorites.
The UI listens to the StateNotifierProvider and rebuilds reactively based on the state (loading, data, or error).
Riverpod ensures a scalable and testable codebase with clean separation of concerns.


⚠️ Known Issues / Limitations
No pagination implemented yet (all articles are loaded at once).

The API fetching is not cached; new network calls are made on app launch and search.

Search queries re-fetch from API instead of searching locally on existing list (can be optimized).

No offline support for article listing (only favorites are saved offline).


 Screenshots
![IMG-20250509-WA0002](https://github.com/user-attachments/assets/a0681b86-1571-43d5-8e81-3e6c31e1967d)
![IMG-20250509-WA0001](https://github.com/user-attachments/assets/4d1a460b-5d05-4289-ba87-9f6be3f2419c)
![IMG-20250509-WA0003](https://github.com/user-attachments/assets/7f8486df-4726-4a51-a708-8f51a7da3afe)
![IMG-20250509-WA0005](https://github.com/user-attachments/assets/4dc8f48f-a125-4cb7-acb4-45cecb88747a)
![IMG-20250509-WA0004](https://github.com/user-attachments/assets/1f36884f-6a29-42cc-83df-b9c17bbc763c)
