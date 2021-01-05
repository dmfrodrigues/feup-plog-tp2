# Copyright (C) 2020-2021 Diogo Rodrigues, Breno Pimentel
# Distributed under the terms of the GNU General Public License, version 3

ZIPNAME=PLOG_TP2_T2_TeCoTuTeCo4

doc/report/report.pdf: FORCE
	make -C $(@D) $(@F)

clean: FORCE
	git clean -dfX

zip: $(ZIPNAME).zip

$(ZIPNAME).zip: doc/report/report.pdf
	rm -rf $(ZIPNAME)
	mkdir -p $(ZIPNAME)
	cp -r doc/report/report.pdf doc/report/test.txt src stats LICENSE README.md $(ZIPNAME)
	cd $(ZIPNAME) && zip -r ../$(ZIPNAME).zip .

FORCE: