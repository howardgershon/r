require(XML)
library(twitteR)
require(twitterR)

get.woeid = function (query, key) {

    query = gsub(" ", "\\%20", query)

    url = paste0("http://where.yahooapis.com/v1/places.q(", query, ")?appid=", key)

    doc = xmlTreeParse(url, useInternalNodes = TRUE)

    top = xmlRoot(doc)

    num = xmlSApply(top[[1]]["woeid"][[1]], xmlValue)

    return(num[[1]])

}

setup.OAuth = function () {
    reqURL = 'https://api.twitter.com/oauth/request_token'
    accessURL = 'https://api.twitter.com/oauth/access_token'
    authURL = 'https://api.twitter.com/oauth/authorize'

    #collect the info
    cat('What is your consumer key? \n')
    consumerKey = readLines(file("stdin"),1)
    cat('What is your consumer secret? \n')
    consumerSecret = readLines(file("stdin"),1)
    cat('What is your Yahoo app ID? \n')
    yahoo.id = readLines(file("stdin"),1)

    #commence OAuth
    twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                                 consumerSecret=consumerSecret,
                                 requestURL=reqURL,
                                 accessURL=accessURL,
                                 authURL=authURL)

    twitCred$handshake()

    registerTwitterOAuth(twitCred)

    cat('Proceed with your use of the twitteR package. Enjoy \n')

}
