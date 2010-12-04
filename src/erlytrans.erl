-module(erlytrans).
-export([translate/4]).

translate(String, From, To, Key) ->
    BaseURL = "https://www.googleapis.com/language/translate/v2?q=" ++ String,
    URL = BaseURL ++ "&key=" ++ Key ++ "&source=" ++ From ++ "&target=" ++ To,
    
    inets:start(),
    ssl:start(),
    Response = http:request(URL),
    {ok, {_, _, JsonData}} = Response,
    {[{_,{[{_,[{[{_,Translation}]}]}]}}]} = json_eep:json_to_term(JsonData),
    Translation.
