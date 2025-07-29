FILENAME=vonLaszewski-2025-workflow
DIR=paper-frontiers
DIR=paper-arxiv

# .PHONY: $(FILENAME).pdf

.PHONY: images

all: $(FILENAME).pdf

# MAIN LATEXMK RULE

$(FILENAME).pdf: $(FILENAME).tex
	latexmk -quiet -deps -bibtex $(PREVIEW_CONTINUOUSLY) -f -pdf -pdflatex="pdflatex -synctex=1 -interaction=nonstopmode" -use-make $(FILENAME).tex

.PRECIOUS: %.pdf
.PHONY: watch

watch: PREVIEW_CONTINUOUSLY=-pvc
watch: $(FILENAME).pdf

.PHONY: clean

images:
	python bin/pdf-to-jpg.py

# | xargs convert -density 300 -trim test.pdf -quality 100


txt:
	#detex $(FILENAME).tex | cat -s > $(FILENAME).txt
	pdftotext -layout $(FILENAME).pdf $(FILENAME).txt

edit:
	emacs $(FILENAME).tex

clean:
	latexmk -C -bibtex
	rm -rf $(FILENAME).spl
	rm -f *_bibertool.bib
	rm -f *.ttt
	rm -f *.blg
	rm -f *.aux

latexdiff-setup:
	mkdir -p tmp
	cd tmp; wget https://github.com/cyberaide/paper-frontiers/archive/refs/tags/v0.1.tar.gz
	cd tmp; tar -xvf v0.1.tar.gz

latexdiff:
	latexdiff tmp/paper-frontiers-0.1/vonLaszewski-frontiers.tex vonLaszewski-frontiers.tex > vonLaszewski-frontiers-diff.tex
	# diff vonLaszewski-frontiers.tex tmp/paper-frontiers-0.1/vonLaszewski-frontiers.tex
	pdflatex $(FILENAME)-diff
	bibtex $(FILENAME)-diff
	pdflatex $(FILENAME)-diff
	pdflatex $(FILENAME)-diff
	open $(FILENAME)-diff.pdf

regular:
	pdflatex $(FILENAME)
	bibtex $(FILENAME)
	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

bib:
	bibexport -o $(FILENAME)-citations.bib $(FILENAME).aux

biber:
	@echo
	biber -V --tool cloud-scheduling.bib | fgrep -v INFO
	@echo
	biber -V --tool cloud-scheduling_bibertool.bib | fgrep -v INFO
	@echo
	biber -V --tool strings.bib | fgrep -v INFO
	@echo
	biber -V --tool vonlaszewski.bib | fgrep -v INFO
	@make -f Makefile clean

#zip: clean
#	cd ..; zip -x "*/.DS*" "*/*.git*" "*/*bin*" "*/*zip" "*/*.md" "*/Makefile" -r $(DIR)/$(FILENAME).zip $(DIR)

flatzip: clean
	zip -x "*.git*" "*bin*" "*zip" "*.md" "Makefile" -r $(FILENAME).zip .

publish:
	cp $(FILENAME).pdf ../../../laszewski/laszewski.github.io/papers/
	cd ../../../laszewski/laszewski.github.io/papers; git add $(FILENAME).pdf
	cd ../../../laszewski/laszewski.github.io/papers; git commit -m "update $(FILENAME)" $(FILENAME).pdf
	cd ../../../laszewski/laszewski.github.io/papers; git push

view:
	open ${FILENAME}.pdf

log:
	code ${FILENAME}.log

zip:
	zip -x "*.git*" "*bin*" "*zip" "*.md" "Makefile" -r $(FILENAME).zip \
	${FILENAME}.tex \
	images \
	${FILENAME}.bib \
	${FILENAME}.pdf \
	${FILENAME}.bbl \
	concepts.tex \
	info.tex \
	s-related-research.tex \
	table.tex \
	vonLaszewski-2025-graph.tex \
	vonLaszewski-2025-req-table.tex \
	vonLaszewski-2025-table-compare.tex \
