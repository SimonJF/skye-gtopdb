#!/usr/bin/env python3
import requests
import sys
import json
import http.client

http.client.HTTPConnection._http_vsn = 11
http.client.HTTPConnection._http_vsn_str = 'HTTP/1.1'

ITERATIONS = 15

def parse_config(filename):
    with open(filename, 'r') as f:
        contents = f.read()
        parsed_json = json.loads(contents)
        linksURL = None
        javaURL = None
        ids = None

        if "linksURL" in parsed_json:
            linksURL = parsed_json["linksURL"]

        if "javaURL" in parsed_json:
            javaURL = parsed_json["javaURL"]

        if "ids" in parsed_json:
            ids = parsed_json["ids"]

        return (parsed_json["name"], ids, linksURL, javaURL)

def make_requests(name, ids, url):
    print("Making requests for page " + name)
    # Some pages (for example, disease list / ligands list)
    # do not have lists of identifiers. In this case, just make
    # the requests to the given URLs
    if ids == None:
        for i in range(0, ITERATIONS):
            print("Making request " + str(i + 1))
            requests.get(url)
    else:
        for identifier in ids:
            print("Beginning requests for ID: " + str(identifier))
            for i in range(0, ITERATIONS):
                print("Making request " + str(i + 1))
                requests.get(url + str(identifier))

def main():
    for filename in sys.argv[1:]:
        (name, ids, links_url, java_url) = parse_config(filename)
        if links_url != None:
            print("==== Requesting Links Version ===")
            make_requests(name, ids, links_url)
        if java_url != None:
            print("==== Requesting Java Version ===")
            make_requests(name, ids, java_url)


if __name__ == "__main__":
    main()
