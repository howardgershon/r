require(XML)

get.woeid = function (query, key) {


    query = gsub(" ", "\\%20", query)

    url = paste0("http://where.yahooapis.com/v1/places.q(", query, ")?appid=", key, "--")

    doc = xmlTreeParse(url, useInternalNodes = TRUE)

    top = xmlRoot(doc)

    num = xmlSApply(top[[1]]["woeid"][[1]], xmlValue)

    return num[[1]]
}
