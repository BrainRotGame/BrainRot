## Reflection
1. Identify which of the course topics you applied (e.g. secure data persistence) and describe how you applied them. In addition to the list of topics enumerated above, you must also describe how your app design reflects what you learned about the Properties of People.

Stateful/Stateless Widgets. Most widgets within our app were stateless, and usually were a consumer of a provider to make updating them very easy. Some widgets like gameView and CreateWord were stateful to allow for user input such as using a TextFormField to create a new world, or in the case of gameview, was necessary because it utilized motion sensors to update itself. 
Data Persistence. Data persistence was implemented with Isar to make it so that all categories and the words within them were persistent. Users can create categories that are persistent, and within each category is another collection of words that is likewise, persistent. If a user opens the app for the very first time, mock data will be loaded into isar so they'll always be presented with some starter categories. 
Motion Sensors. Motion sensors were implemented within the gameView, which added a little more engagement to the app by allow users to simply flip their phone up/down to traverse through each word. Additionally, we also considered devices that don't have functioning motion sensors, which's also why we implemented tappable buttons on the gameView that allows users to traverse through each word without the need of flipping their phone. 
Drawing & Undo/Redo. Drawing was used in conjunction with the gameView. The implementation of Drawing would allow users to create drawings and engage with their peers by having one individual draw a term, whilst the others attempted to guess their drawing. We also implemented tool features like undo/redo, which would make it easier for users to draw and undo their mistake. 
Across the entire app we have semantics in place for buttons, tooltips describing what each button does whenever you hover over them, and all elements in the app have strong colors (each with a 4.5:1 contrast ratio) and have have sufficient size, making it easier to see and differentiate UI elements/text. 

2. Discuss how doing this project challenged and/or deepened your understanding of these topics.

Implementing Isar was far and away the single-most difficult aspect of the app to implement. Much of our understanding of Isar largely came from Journal, but Journal's implementation didn't get us very far. What mainly made implementing Isar difficult was understanding how to implement nested collections and having multiple schemas. Understanding how to get multiple collections to communicate with eachother took awhile to figure out. Now knowing about IsarLinks and backLinks and how they serve to form links between collections is incredibly valuable. In the future, using an IsarService to handle all the Isar writes rather than directly placing Isar within objects or constantly passing Isar in as a method might be a more practical way of handling persistent data. 

3. Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?

Much of our app stayed pretty close to our original scaffold back when we first began developing our app. As we tested, we did notice not many people had a good understanding of how to navigate our app, which's why later down the line we ended up implementing help popups in each page which would inform the user of what to do on each page. 

4. Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app

An accessibility aspect we really overlooked was that in order to really participate in the game aspect of our app, you need to SEE the drawing and word. For someone with impaired vision, this makes it incredibly difficult and near impossible to play because they won't be able to see the drawing, and there's not a way to simply have semantics for it. Having an alternative option to playing the game other than drawing would make our app much more accessible to those with visual impairments. 
As previously mentioned, when we were SUS testing, many people didn't immediately understand how to navigate the app (ie: many people didn't realize they could long tap to edit a category, some were a little lost on how the gameView page worked, etc). We developed a quick band-aid fix by simply placing a bunch of popup dialogues in all the pages so incase users ever got lost, they could use the popups to gain an understanding of what to do. While we do think the popups helped, using the popups was pretty much mandatory to fully understanding how to navigate the app, where practically speaking it'd be best if users never needed to use the helper popups in the first place, and instead relied on the clarity of the UI to figure it out themselves. 

5. Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment. Remember to include all online resources such as Stack Overflow, blogs, students in this class, or TAs and instructors who helped you during OH

Much of the gameview features were inspired from Heads Up! and Pictionary.
Much of the drawing implementation was taken from the drawing homework we previously did and expanded upon. 
Information about Isar links was taken from here: https://isar.dev/links.html
Many of the staff members such a Joann, Harry, Dhruv, and Ben assisted in the developement of the app. 
Motion sensors were taken from the flutter docs: https://pub.dev/packages/sensors_plus

