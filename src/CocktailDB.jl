# Copyright 2022 XXIV
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
module CocktailDB

using HTTP
using JSON

export search, searchbyLetter, searchingredient
export search_ingredient_byid, filter_byingredient
export categoriesfilter, glassesfilter, ingredientsfilter
export alcoholicfilter, random, search_byid, filter_byglass
export filter_byalcoholic, filter_bycategory

struct CocktailDBException <: Exception
    msg
end

function _getrequest(endpoint::String)
    try
        request = HTTP.request("GET", "https://thecocktaildb.com/api/json/v1/1/$endpoint")
        response = String(request.body)
        return response
    catch ex
        if isa(ex, HTTP.ExceptionRequest.StatusError)
            return String(ex.response.body)
        else
            rethrow(ex)
        end
    end
end

"""
Search cocktail by name

* `s` cocktail name

"""
function search(s::String)
    try
        response = _getrequest("search.php?s=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Search cocktails by first letter

* `c` cocktails letter

"""
function searchbyLetter(c::Char)
    try
        response = _getrequest("search.php?f=$c")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Search ingredient by name

* `s` ingredient name

"""
function searchingredient(s::String)
    try
        response = _getrequest("search.php?i=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["ingredients"] == nothing || length(json["ingredients"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["ingredients"][1]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Search cocktail details by id

* `i` cocktail id

"""
function search_byid(i::Int)
    try
        response = _getrequest("lookup.php?i=$i")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"][1]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Search ingredient by ID

* `i` ingredient id

"""
function search_ingredient_byid(i::Int)
    try
        response = _getrequest("lookup.php?iid=$i")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["ingredients"] == nothing || length(json["ingredients"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["ingredients"][1]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Search a random cocktail

"""
function random()
    try
        response = _getrequest("random.php")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"][1]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Filter by ingredient

* `s` ingredient name

"""
function filter_byingredient(s::String)
    try
        response = _getrequest("filter.php?i=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Filter by alcoholic

* `s` alcoholic or non alcoholic

"""
function filter_byalcoholic(s::String)
    try
        response = _getrequest("filter.php?a=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Filter by Category

* `s` category name

"""
function filter_bycategory(s::String)
    try
        response = _getrequest("filter.php?c=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
Filter by Glass

* `s` glass name

"""
function filter_byglass(s::String)
    try
        response = _getrequest("filter.php?g=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        return json["drinks"]
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
List the categories filter

"""
function categoriesfilter()
    try
        response = _getrequest("list.php?c=list")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        array = String[]
        for i in json["drinks"]
        	push!(array, i["strCategory"])
        end
        return array
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
List the glasses filter

"""
function glassesfilter()
    try
        response = _getrequest("list.php?g=list")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        array = String[]
        for i in json["drinks"]
        	push!(array, i["strGlass"])
        end
        return array
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
List the ingredients filter

"""
function ingredientsfilter()
    try
        response = _getrequest("list.php?i=list")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        array = String[]
        for i in json["drinks"]
        	push!(array, i["strIngredient1"])
        end
        return array
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

"""
List the alcoholic filter

"""
function alcoholicfilter()
    try
        response = _getrequest("list.php?a=list")
        if length(response) == 0
            throw(CocktailDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["drinks"] == nothing || length(json["drinks"]) == 0
           throw(CocktailDBException("Something went wrong: Empty response"))
        end
        array = String[]
        for i in json["drinks"]
        	push!(array, i["strAlcoholic"])
        end
        return array
    catch ex
        if isa(ex, CocktailDBException)
            rethrow(ex)
        else
            throw(CocktailDBException(sprint(showerror, ex)))
        end
    end
end

end # CocktailDB