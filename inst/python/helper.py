import os
import requests
import sys
import re
from bs4 import BeautifulSoup

def existFile(pathToFile):
    """
    :param pathToFile: entire path to the file
    :return: return True if the file already exist, else return False
    """
    return (os.path.isfile(pathToFile))


def formatPathToFile(nameFile):
    """
    :param nameFile: name of the file with its extension
    :return: return the entire path to the file
    """

    # remove char until '/'
    pathToFile = os.path.dirname(__file__)
    #while not (pathToFile.endswith('/')):
    #    pathToFile = pathToFile[0:-1]

    pathToFile += '/resources/'+nameFile
    return pathToFile


def loadFileURL(nameFile, url):
    """
    Download the file located in the rapdb download page

    :param nameFile: name of the file (the all path to the file if you want to save the file in another folder)
    :param url: url where is located the file

    """

    # Fetch the file by the url and decompress it
    r = requests.get(url)

    # Create the file .txt
    with open(nameFile, "wb") as f:
        f.write(r.content)
        print("File created")
        f.close()


def connectionError(link):
    """
    Test website issues and returns requests.get(link) result

    :param link: URL
    :return: requests.get(link)
    """
    try:
        html_page = requests.get(link, allow_redirects=False)

        if (html_page.status_code == 302 or html_page.status_code == 307):
            print("Website maintenance")
            sys.exit(1)

        elif (html_page.status_code == 400):
            print("Bad request")
            sys.exit(1)


        elif (html_page.status_code == 403):
            print("Forbidden")
            sys.exit(1)


        elif (html_page.status_code == 404):
            print("Not found")
            sys.exit(1)


        elif (html_page.status_code == 429):
            print("Too Many Requests")
            sys.exit(1)


        elif (html_page.status_code == 500):
            print("Internal Server Error")
            sys.exit(1)


        elif (html_page.status_code == 503):
            print("Service Unavailable")
            sys.exit(1)


        elif (html_page.status_code == 504):
            print("Gateway Timeout")
            sys.exit(1)


        elif (html_page.status_code == 505):
            print("HTTP Version Not Supported")
            sys.exit(1)


        elif (html_page.status_code > 299):
            print("Unknow internet error")
            sys.exit(1)

        else:
            return html_page

    except requests.exceptions.RequestException:
        print("Unknow internet error")
        sys.exit(1)

    except requests.exceptions.Timeout:
        print("Timeout")
        sys.exit(1)



def connectionErrorPost(link, data):

    """
    Return requests.get(link) with post request and test website issues

    :param link: URL
    :param data: data to give to the form
    :return: requests.get(link)
    """
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.0; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0'}
        html_page = requests.post(link, data=data, headers=headers)


        if (html_page.status_code == 302 or html_page.status_code == 307):
            print("Website maintenance")
            sys.exit(1)

        elif (html_page.status_code == 400):
            print("Bad request")
            sys.exit(1)


        elif (html_page.status_code == 403):
            print("Forbidden")
            sys.exit(1)


        elif (html_page.status_code == 404):
            print("Not found")
            sys.exit(1)


        elif (html_page.status_code == 429):
            print("Too Many Requests")
            sys.exit(1)


        elif (html_page.status_code == 500):
            print("Internal Server Error")
            sys.exit(1)


        elif (html_page.status_code == 503):
            print("Service Unavailable")
            sys.exit(1)


        elif (html_page.status_code == 504):
            print("Gateway Timeout")
            sys.exit(1)


        elif (html_page.status_code == 505):
            print("HTTP Version Not Supported")
            sys.exit(1)


        elif (html_page.status_code > 299):
            print("Unknow internet error")
            sys.exit(1)

        else:
            return html_page

    except requests.exceptions.RequestException:
        print("Unknow internet error")
        sys.exit(1)

    except requests.exceptions.Timeout:
        print("Timeout")
        sys.exit(1)

def single_gene_query(db, RAPID):

    #database descriptor querry
    database_descriptor = BeautifulSoup(open("database-description.xml").read(), "xml").findAll("database", dbname=db.lower())
    if not database_descriptor:
        raise ValueError('Database Not Found')
    if database_descriptor[0]["method"]=="POST":
        link = database_descriptor[0].findAll("link")[0]["stern"]
        data = {'rapId': RAPID}
        html_page = connectionErrorPost(link, data)
    elif database_descriptor[0]["method"]=="GET":
        link = database_descriptor[0].findAll("link")[0]["stern"] + RAPID + database_descriptor[0].findAll("link")[0]["aft"]
        html_page = connectionError(link)
    
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
    ret = BeautifulSoup(html_page.content, "lxml")
    data = ret.findAll(database_descriptor[0].findAll("data_struct")[0]["indicator"], {database_descriptor[0].findAll("data_struct")[0]["identifier"] : database_descriptor[0].findAll("data_struct")[0]["identification_string"]})[0]

    # #header detection
    # for header in data.findAll('th'):
    #     header = header.text.replace('\r', '')
    #     header = header.replace('\n', '')
    #     header = header.replace('\t', '')
    #     # print(header.text)
    #     headers.append(header)

    #parsing data to dictionary
    dict = {}
    count = 0
    # data = ret.findAll('table')[0]
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