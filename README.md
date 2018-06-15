# Pic2Go

See where you can go, and go where you can see.

## Member

B02505012 梁浩穎
R06922055 吳均庭
R06922026 柯東爵

## Introduction

## Pic2Go-Server

Server for Pic2Go, written in `python3` with `Flask`.


### Usage (For Development ONLY)

1. (Preferably in a Virtualenv) `pip install -r requirements.txt`
2. `env FLASK_APP=pic2go.py FLASK_ENVIRONMENT=development flask run`
3. `curl -F 'pic=@test.jpg' 'http://127.0.0.1:5000/'`

## Pic2Go Client

iOS Client for Pic2Go, written in `swift`.

### Environment

* Xcode 9.3 
* Swift 4 
* iOS 11.3
* ruby 2.5.0
* Alamofire 4.7

### Installing

A step by step series of examples that tell you how to get a development env running

[Alamofire source](https://github.com/Alamofire/Alamofire)

Install CocaPods

```
gem install cocoapods
```

And

```
pod install
```
