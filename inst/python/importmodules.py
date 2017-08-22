#!/usr/bin/env python3

import importlib
import pip

def install(package):
    pip.main(['install', package])

def main():
    install("pandas")
    install("bs4")
    install("requests")
    install("json")
    install("gzip")
    install("lxml")


# Pour eviter que le script soit execute lors d'un simple import
if __name__ == "__main__":
    main()
