#!/usr/bin/env python3

import pip

def install(package):
    pip.main(['install', package])

def main():
    try:
        install("pandas")
        install("bs4")
        install("requests")
        install("json")
        install("gzip")
        install("lxml")
    except:
        pass


# Pour eviter que le script soit execute lors d'un simple import
if __name__ == "__main__":
    main()
