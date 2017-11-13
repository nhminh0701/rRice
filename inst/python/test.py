#!/usr/bin/env python3

import helper

# print(multiple_gene_query("oryzabase",["Os07g0586200", "Os03g0149100"]))
print("Oryzabase Query: ")
print(helper.single_gene_query("oryzabase", "Os03g0149100"))
print("\nRapDB Query")
print(helper.single_gene_query("rapdb", "Os03g0149100"))