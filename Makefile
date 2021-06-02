################################################################################
# VARIABLES                                                                    #
################################################################################

PROJECT_ROOT:=$(dir $(realpath $(lastword $(MAKEFILE_LIST))))

################################################################################
# COMMANDS                                                                     #
################################################################################

## Prepare correctly mapped data
reports: reports/raw_comp_summary.pdf reports/raw_comp_summary.html reports/raw_chem_summary.pdf reports/raw_chem_summary.html reports/raw_reac_summary.pdf reports/raw_reac_summary.html reports/db_compartment_summary.pdf reports/db_compartment_summary.html reports/db_compound_summary.pdf reports/db_compound_summary.html reports/db_reaction_summary.pdf reports/db_reaction_summary.html reports/reduced_set_summary.pdf reports/reduced_set_summary.html

reports/raw_comp_summary.pdf: reports/raw_comp_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'pdf_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(comp_prop = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_comp_prop.tsv', comp_xref = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_comp_xref.tsv', comp_depr = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_comp_depr.tsv'))"

reports/raw_comp_summary.html:reports/raw_comp_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'html_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(comp_prop = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_comp_prop.tsv', comp_xref = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_comp_xref.tsv', comp_depr = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_comp_depr.tsv'))"

reports/raw_chem_summary.pdf: reports/raw_chem_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'pdf_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(chem_prop = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_chem_prop.tsv', chem_xref = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_chem_xref.tsv', chem_depr = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_chem_depr.tsv'))"

reports/raw_chem_summary.html: reports/raw_chem_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'html_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(chem_prop = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_chem_prop.tsv', chem_xref = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_chem_xref.tsv', chem_depr = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_chem_depr.tsv'))"

reports/raw_reac_summary.pdf: reports/raw_reac_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'pdf_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(reac_prop = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_reac_prop.tsv', reac_xref = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_reac_xref.tsv', reac_depr = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_reac_depr.tsv'))"

reports/raw_reac_summary.html: reports/raw_reac_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'html_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(reac_prop = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_reac_prop.tsv', reac_xref = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_reac_xref.tsv', reac_depr = '$(PROJECT_ROOT)../metanetx-nf/results/mnx-4.2-processed/processed_reac_depr.tsv'))"

reports/db_compartment_summary.pdf: reports/db_compartment_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'pdf_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

reports/db_compartment_summary.html: reports/db_compartment_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'html_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

reports/db_compound_summary.pdf: reports/db_compound_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'pdf_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

reports/db_compound_summary.html: reports/db_compound_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'html_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

reports/db_reaction_summary.pdf: reports/db_reaction_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'pdf_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

reports/db_reaction_summary.html: reports/db_reaction_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'html_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

reports/reduced_set_summary.pdf: reports/reduced_set_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'pdf_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

reports/reduced_set_summary.html: reports/reduced_set_summary.Rmd
	Rscript -e "rmarkdown::render('$(PROJECT_ROOT)$<', output_format = 'html_document',  encoding = 'UTF-8', knit_root_dir = '$(PROJECT_ROOT)', params = list(database = '$(PROJECT_ROOT)../metanetx.sqlite'))"

################################################################################
# Self Documenting Commands                                                    #
################################################################################

.DEFAULT_GOAL := show-help

# Inspired by
# <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: show-help
show-help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && \
		echo '--no-init --raw-control-chars')
