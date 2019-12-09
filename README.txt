# A

# Architecture decisions

We chose MVP architecture for this project because we think that it would help as create clean component that could be easily tester, which ended app beign the case. The Presenter for the Game componenet has several Unit Test that guarantee it's coherence.

For the main ViewController we though of implementing a MVVM architecture. This would make the UI more responsive: Once the user enters the right names, then the 'Start Game' button is enabled. If for some reason the Input is not correct, the 'Start Game' button would again become un available. We thought that this might be a short win for implementing such an architecture, and we normally use RxSwift for binding those components, and we wanted to keep the project simple (with not extra frameworks).

# Decisions for the future

- We used 3 modular cels (CurrentPlayerTableViewCell, QuestionTableViewCell and AnswerTableViewCell) because we think that is most probable that this game will have a skin added in the near future, and having this cells around will make that implementation easier.
- We
