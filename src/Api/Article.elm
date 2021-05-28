module Api.Article exposing (Article, Listing, updateArticle)

{-|

@docs Article, Listing, updateArticle

-}

import Api.Profile exposing (Profile)
import Time


type alias Article =
    { slug : String
    , title : String
    , description : String
    , body : String
    , tags : List String
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , favorited : Bool
    , favoritesCount : Int
    , author : Profile
    }


type alias Listing =
    { articles : List Article
    , page : Int
    , totalPages : Int
    }


updateArticle : Article -> Listing -> Listing
updateArticle article listing =
    let
        articles : List Article
        articles =
            List.map
                (\a ->
                    if a.slug == article.slug then
                        article

                    else
                        a
                )
                listing.articles
    in
    { listing | articles = articles }



-- INTERNALS


itemsPerPage : Int
itemsPerPage =
    25



-- @TODO re-implement pagination
-- paginatedDecoder : Int -> Json.Decoder Listing
-- paginatedDecoder page =
-- let
--     multipleArticles : List Article -> Int -> Listing
--     multipleArticles articles count =
--         { articles = articles
--         , page = page
--         , totalPages = count // itemsPerPage
--         }
-- in
-- Json.map2 multipleArticles
--     (Json.field "articles" (Json.list decoder))
--     (Json.field "articlesCount" Json.int)
