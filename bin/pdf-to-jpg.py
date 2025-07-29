#!/usr/bin/env python

from cloudmesh.common.util import readfile
import glob
import os
fls = glob.glob("*.fls")[0]


content = readfile(fls).replace("INPUT ", "").splitlines()

content = set([name for name in content if "./images" in name])

for pdf in content:
    jpg = pdf.replace(".pdf", ".jpg").replace(".png", ".jpg")

    if not os.path.exists(jpg):
        print (pdf, "->", jpg)
        command = f"convert -density 300 -trim {pdf} -quality 100 {jpg}"
        os.system(command)


	       #
