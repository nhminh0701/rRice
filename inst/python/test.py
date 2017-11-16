#!/usr/bin/env python3

import query

# print("Oryzabase Query: ")
# print(query.query("oryzabase", ["Os01g0102700"]))
# print("\nRapDB Query")
# print(query.query("rapdb", ["Os01g0102700"]))
# print("\nGramene Query")
# print(query.query("Gramene", ["Os03g0149100"]))
# print("\nic4r Query")
# print(query.query("ic4r", ["Os03g0149100"]))
# print("\nplntfdb Query")
# print(query.query("plntfdb", ["321718"]))
# print("\nSNP-Seek Query")
# print(query.query("snpseek", ["chr01", "1", "43270923", "rap"]))
# print("\nfunricegene Query")
# for iter in query.query("funricegene_genekeywords", ["","LOC_Os07g39750"]):
#     print(iter)
# print("\nfunricegene Query")
# for iter in query.query("funricegene_geneinfo", ["","LOC_Os07g39750"]):
#     print(iter)
print("\nfunricegene Query")
for iter in query.query("funricegene_faminfo", ["","LOC_Os07g39750"]):
    print(iter)
# print("\nMSU Query")
# for iter in query.query("msu", ["LOC_Os10g01006"]):
    # print(iter)