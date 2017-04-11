# TwitchClientSwift
TwitchClient, Developed by Ahmed Kotb

This is a simple app designed to retrieve data from the Famous Twitch API, to list the top 5 most popular games streamed on Twitch and list the top 10 most viewed streams for each game.

The API had 2 main JSON objects that I needed to use in order to deliver the app’s purpose:

1. Game
2. Stream

both of these 2 objects had key objects within them that had numerous properties so it was better to treat them as separate objects which are:

1. Channel: which was within the Stream object and defined a lot of its key properties.
2. Image: which was within both Game and Stream objects.

I also created a Manager to handle all the web services operations and populate the created objects with the right data. it has a protocol and 2 methods:

1. getTopGames: which calls the URL to get the top 5 games and when finished, it fires the protocol method either to indicate that the retrieval process has been done and sends the retrieved array to the View Controller, or to indicate that an error happened.

2. getStreamsForGame: which calls the URL to get the top most viewed 10 streams for a specific game, this game is indicated by a parameter sent to this method of type String. it fires the protocol method either to indicate that the retrieval process has been done and sends the retrieved array to the View Controller, or to indicate that an error happened.

the reason that I used only one protocol with nullable parameters is that Swift doesn’t allow optional delegate methods so it was more convenient to use only one method for everything.

I then created the views design in the storyboard and created their classes which just call the web service manager’s methods through an instance of it and retrieve the data using the above delegate protocol, then Draw the table view cells by passing the required data to the custom cells I created for each table.

I used Cocapods to integrate 3 third party libraries:

1. Alamofire: which is a great HTTP networking library which enables the developer to make and HTTP request in just one line and get the response in a block without the need to write many methods.

2. SDWebImage: This Library provides an async image downloader with cache support.

3. SVProgressHud: This is a very sleek looking, easy to use activity indicator.
—————————————————————————————————————————————


 This App has the potential to have a lot more features, I thought of one which is that we can add a feature in which the user can add a game to his favourite list and follow it so he get a notification whenever a new stream is available.
 Also, what I was thinking of is that the App we have right now can be only a feature in a very large app in which we get the streams from twitch and get the game news from other sources, maybe implement a module in which the user can be directed to the place he can buy the game either online or in a physical store.
 Maybe also a chat feature in which there would be a chat room for each game or even give the user the ability to create a chat room for a certain game. This App has literally a huge potential to be a deal breaker especially if you’re passionate about games.
