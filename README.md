Pic2Go
======

Pic2Go is an iOS application that takes you to the local places that you'd like to go. Imagine that one day you see a beautiful picture on Instagram; it's a scenic place faraway from your country, say, the Niagara Falls, and you're like, *"Wow, that's spectacular. Wish one day I could go see it in person."*

For most people, that'd be a luxurious dream that takes many years of hard-working before it finally comes true. However, you don't really have to go to such a faraway place to see a breathtaking waterfall. In fact, there are an abundance of gorgeous waterfalls in Taiwan. Maybe they're not that much awe-inspiring, but they're far from not being as magnificent as the Niagara Falls to be worth your time taking a trip to. But how do you know where those waterfalls are? That's what Pic2Go will tell you.

Whenever you see a picture of a beautiful but faraway place that you want to go, you'd just download that picture, upload it to Pic2Go, and it'll find you the most similar, and as beautiful, places around in Taiwan. So, what are you waiting for? See where you can go, and go where you can see.

To look into more details, please be sure to check out our [poster](https://drive.google.com/file/d/1pZ4C_jid4DlUx6kQC164sRgC8kJMOIlb/view).*


## Members

* B02505012 梁浩穎
* R06922055 吳均庭
* R06922026 柯東爵


## Screenshots & Demo Video

Screenshots can be found in the repository at `screenshots/`, and the demo video can be found either in the repository at `DemoVideo.mov`, or [on YouTube](https://www.youtube.com/watch?v=Po6TzwhD_S8&feature=youtu.be).


## Pic2Go-Server

Server for Pic2Go, written in `python3` with `Flask`.

#### Usage (For Development ONLY)

1. (Preferably in a Virtualenv) `pip install -r requirements.txt`
2. `env FLASK_APP=pic2go.py FLASK_ENVIRONMENT=development flask run`
3. `curl -F 'pic=@test.jpg' 'http://127.0.0.1:5000/'`


## Pic2Go-Client

iOS Client for Pic2Go, written in `swift`.

#### Environment

* Xcode 9.3 
* Swift 4 
* iOS 11.3
* ruby 2.5.0
* Alamofire 4.7

#### Usage

1. gem install cocoapods
2. pod install
