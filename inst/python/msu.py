#!/usr/bin/env python3

import helper
import re
from bs4 import BeautifulSoup
import json

def msu(id):

    link = "http://rice.plantbiology.msu.edu/cgi-bin/sequence_display.cgi?orf="+id
    html_page = helper.connectionError(link)
    soup = BeautifulSoup(html_page.content, "lxml")

    headers = ["Genomic Sequence", "CDS", "Protein"]
    dict = {}
    i = 0
    regex = re.compile("\n>LOC_.*\n|\n", re.IGNORECASE)
    for search in soup.findAll('pre'):
        # dataFormat = search.text.replace('>'+id, '')
        # dataFormat = dataFormat.replace('\n', '')
        dataFormat = regex.sub("", search.text)
        dict[headers[i]] = dataFormat
        i = i + 1

    return dict



print(msu("LOC_Os10g01006"))
