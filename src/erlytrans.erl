-module(erlytrans).
-export([translate/4]).

translate(String, From, To, Key) ->
    BaseURL = "https://www.googleapis.com/language/translate/v2?q=" ++ edoc_lib:escape_uri(String),
    URL = BaseURL ++ "&key=" ++ Key ++ "&source=" ++ From ++ "&target=" ++ To,
    
    inets:start(),
    ssl:start(),
    Response = http:request(URL),
    {ok, {{_,Status,_}, _, JsonData}} = Response,
    if
	Status =:= 200 -> {[{_,{[{_,[{[{_,Translation}]}]}]}}]} = json_eep:json_to_term(JsonData),
			  Translation;
        Status =:= 400 -> erlang:error("Bad languages pair");
	(Status =/= 200) and (Status =/= 400) -> elang:error("Unsuccessful api request")
    end.
