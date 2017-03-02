# README

Simple CRUD app that will take the place of the paper notecards I currently use when learning something new.

The app is currently functioning and I am testing it out on https://stark-thicket-39135.herokuapp.com/ while I learn Elixir.

List of Bugs:

-Fix styling
  -currently doesn't look great in mobile

Features to add:

-User Auth
  -requires updating schema to create User table and attach user_id to flash_card
  -prevent users from editing other people's cards
  -allow users to view other people's cards
  -Devise gem is probably a good choice here
  
-Hide cards that you know
  -cards that you have correclty answered 10 straight times AND haven't viewed in 2 months should not be displayed while reviewing a category
