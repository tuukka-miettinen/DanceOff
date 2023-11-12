## 💃 DanceOff
An app where every move counts! Elevate your dance game, challenge friends, and create your own signature moves in this dynamic and engaging app designed for the rhythm-driven generation.

### ❓What
The ultimate dance challenge app that brings the thrill of dancing to the fingertips of children and other dance-minded individuals around the world. In this innovative and health-focused project, we've crafted a platform that goes beyond mere entertainment – it's a journey towards improved well-being through the joy of movement.

### 🤷‍♂️Why
With childhood obesity being a growing problem, our aim is to help people get moving and get exercise. The app motivates people to do dance moves by providing a fun user experience and giving the users competition through leaderboards.

The app will remind people to move without making it feel like a chore. It is a fun way to express yourself and keep fit.

### 📖How
The app provides a list of dance moves that you can do. By doing these moves, you will get points based on how well you did the dance moves. By earning points, you can be on the top of the leaderboard among everyone or a group of close friends!

### ⚙️Technical details
The dance tracking is implemented in Swift using the Core Motion framework provided by apple. The core motion data is monitored in a window, which is compared to the set of currently known dance moves. If the window matches a dance move well enough, the app will start to track the moves for a longer time. After the move is fully tracked, the accuracy is calculated using Dynamic Time Warping and euclidean distance between the known movement data and the collected data.

### ⭐Future
Get the whole world dancing! 
(Also improve the app to use machine learning for move tracking)

### Demo
https://youtu.be/S4qdbA9P5iE
