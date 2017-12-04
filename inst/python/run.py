#!/usr/bin/env python3

import os
import sys
import helper
import query
import planttfdb as planttfdb
import click

@click.command()
@click.argument('db', nargs=1)
@click.argument('qfield', nargs=-1)

def main(db, qfield):
    print(query.query(db, qfield))


if __name__ == "__main__":
    main()