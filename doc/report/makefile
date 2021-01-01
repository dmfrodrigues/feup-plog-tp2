LATEXMK=latexmk -f -interaction=nonstopmode -pdf #-quiet -silent

all: report.pdf

report.pdf: report.tex
	chmod u+x get-commit-info.sh
ifeq ($(VERSION),)
	cd $(<D) && $(LATEXMK) $(<F)
else
	cd $(<D) && (echo "$(VERSION)" > VERSION) && $(LATEXMK) $(<F) && $(RM) VERSION
endif

clean: FORCE
	git clean -dfX

FORCE:
