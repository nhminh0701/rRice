#!/usr/bin/env python3

import helper
import re
import requests
from bs4 import BeautifulSoup
import sys

def single_gene_query(db, RAPID):

    #database descriptor querry
    data = {'rapId': RAPID}
    database_descriptor = BeautifulSoup(open("database-description.xml").read(), "xml").findAll("database", dbname=db.lower())
    if not database_descriptor:
        raise ValueError('Database Not Found')
    link = database_descriptor[0].findAll("link")[0].text
    # Headers declaration
    headers = []
    for header in database_descriptor[0].findAll("header"):
        headers.append(header.text)
    # headers.append("CGSNL Gene Symbol")
    # headers.append("Gene symbol synonym(s)")
    # headers.append("CGSNL Gene Name")
    # headers.append("Gene name synonym(s)")
    # headers.append("Chr. No.")
    # headers.append("Trait Class")
    # headers.append("Gene Ontology")
    # headers.append("Trait Ontology")
    # headers.append("Plant Ontology")
    # headers.append("RAP ID")
    # headers.append("Mutant Image")

    #connection handling
    html_page = helper.connectionErrorPost(link, data)
    ret = BeautifulSoup(html_page.content, "lxml")

    #parsing data to dictionary
    dict = {}
    count = 0
    data = ret.findAll('table', {"class": "table_summery_list table_nowrapTh max_width_element"})[0]
    i = 0
    for datafound in data.findAll('td'):
        dataFormat = datafound.text.replace('\r', '')
        dataFormat = dataFormat.replace('\n', '')
        dataFormat = dataFormat.replace('\t', '')
        dict[headers[i]] = dataFormat
        i = i + 1

    return dict

def multiple_gene_query(db, geneList):
    ret = []
    for gene in geneList:
        ret.append(single_gene_query(db, gene))
    return ret

print(multiple_gene_query("oryzabase",["Os07g0586200", "Os03g0149100"]))