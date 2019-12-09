## Architecture decisions

We chose MVP architecture for this project because we think that it would help as create clean component that could be easily tested, which ended app beign the case. The Presenter for the Game componenet has several Unit Test that guarantee it's coherence.

For the main ViewController we though of implementing a MVVM architecture. This would make the UI more responsive: Once the user enters the right names, then the 'Start Game' button is enabled. If for some reason the Input is not correct, the 'Start Game' button would again become un available. We thought that this might be a short win for implementing such an architecture, and we normally use RxSwift for binding those components, and we wanted to keep the project simple (with not extra frameworks) so in turn we created a plain MVC architecture.

## Decisions for the future

- We used 3 modular cels (CurrentPlayerTableViewCell, QuestionTableViewCell and AnswerTableViewCell) because we think that is most probable that this game will have a skin added in the near future, and having this cells around will make that implementation easier.

## Unit Test

This application has several UnitTesting that guarantee it's coherence. The perks of implementing this kind of test are that regressions are more unlikelike to appear as the models grows to support new features or changes, making the software more difficult to `brake.` On the other hand, out philosophy is making ViewControllers as dumb as possible, in order to make their testing trivial through manual means, and putting the more logic and complex stuff inside Presenters that can be throughly tested.

![alt text](http://www.landhsoft.com/tests.png "Unit Tests")


## App UI Render

This is how the apps renders:
![alt text](http://www.landhsoft.com/app_ui.png "Unit Tests")
