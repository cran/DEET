## ----install_developter, eval=FALSE-------------------------------------------
#  
#  devtools::install_github("wilsonlabgroup/DEET")
#  

## ----install_cran, eval=FALSE-------------------------------------------------
#  
#  # IN DEVELOPMENT
#  

## ----download_data, eval=FALSE------------------------------------------------
#  
#  downloaded <- DEET_data_download("ALL")
#  metadata <- downloaded$metadata
#  DEET_feature_extract_input <- downloaded$DEET_feature_extract
#  DEET_enrich_input <- downloaded$DEET_enrich
#  

## ----orders_list, eval=FALSE--------------------------------------------------
#  
#  DEG_list <- c("a", "b", "c", "d") # list of genes user inputs
#  
#  DEG_processed <- data.frame(gene_symbol = DEG_list)
#  # DEG list is the list of genes that the user inputs
#  
#        padj <- 0.049
#        for(i in 2:nrow(DEG_processed)) {
#          padj[i] <- padj[i-1] * 0.95
#        }
#        padj <- rev(padj)
#        log2fc <- rev(seq(1, 1 + 0.1*(nrow(DEG_processed) - 1), 0.1))
#  
#        DEG_processed$padj <- padj
#        DEG_processed$coef <- log2fc
#        colnames(DEG_processed) <- c("gene_symbol", "padj", "coef")
#  
#  

## ----DEET_enrich_DF, eval=FALSE-----------------------------------------------
#  
#  data("example_DEET_enrich_input")
#  data("DEET_example_data")
#  DEET_out <- DEET_enrich(example_DEET_enrich_input, DEET_dataset = DEET_example_data)
#  
#  

## ----DEET_enrich_ordered, eval=FALSE------------------------------------------
#  
#  data("example_DEET_enrich_input")
#  data("DEET_example_data")
#  
#  geneList <- example_DEET_enrich_input$gene_symbol
#  DEET_out <- DEET_enrich(geneList, DEET_dataset = DEET_example_data, ordered = TRUE)
#  
#  

## ----DEET_enrich_unordered, eval=FALSE----------------------------------------
#  
#  data("example_DEET_enrich_input")
#  data("DEET_example_data")
#  
#  geneList <- example_DEET_enrich_input$gene_symbol
#  DEET_out <- DEET_enrich(geneList, DEET_dataset = DEET_example_data, ordered =FALSE)
#  
#  

## ----DEET_feature_extract_example, eval=FALSE---------------------------------
#  
#  data(DEET_feature_extract_example_matrix)
#  data(DEET_feature_extract_example_response)
#  single1 <- DEET_feature_extract(DEET_feature_extract_example_matrix,
#  DEET_feature_extract_example_response,"categorical")
#  

## ----proccess_and_plot_DEET_enrich_main, eval=FALSE---------------------------
#  
#  data("example_DEET_enrich_input")
#  data("DEET_example_data")
#  DEET_out <- DEET_enrich(example_DEET_enrich_input, DEET_dataset = DEET_example_data)
#  plotting_example <- proccess_and_plot_DEET_enrich(DEET_out, text_angle = 45,
#  horizontal = TRUE, topn=4)
#  

## ----proccess_and_plot_DEET_enrich_miss, eval=FALSE---------------------------
#  
#  data("example_DEET_enrich_input")
#  data("DEET_example_data")
#  DEET_out <- DEET_enrich(example_DEET_enrich_input, DEET_dataset = DEET_example_data)
#  DEET_out$AP_DEET_DE_output <- "No enrichment to be plotted"
#  plotting_example <- proccess_and_plot_DEET_enrich(DEET_out, text_angle = 45,
#  horizontal = TRUE, topn=4)
#  

## ----Prep_DEET_enrichment_plot, eval=FALSE------------------------------------
#  
#  DE_example <- DEET_out$AP_DEET_DE_output$results
#  
#  # Changes for DEET_example_plot
#  DE_example$term.name <- DEET_out$AP_DEET_DE_output$metadata$DEET.Name
#  DE_example$domain <- "DE"
#  DE_example$overlap.size <- lengths(DE_example$overlap)
#  DE_example$p.value <- DE_example$adjusted.p.val
#  
#  DE_example_plot <- DEET_enrichment_plot(list(DE_example = DE_example), "DE_example")
#  
#  

## ----correlation_plots, eval=FALSE--------------------------------------------
#  
#  data("example_DEET_enrich_input")
#  data("DEET_example_data")
#  DEET_out <- DEET_enrich(example_DEET_enrich_input, DEET_dataset = DEET_example_data)
#  correlation_input <- DEET_out$DE_correlations
#  correlation_plots <- DEET_plot_correlation(correlation_input)
#  

## ----DEET_gmt_save, eval=FALSE------------------------------------------------
#  
#  DEET_gmt <- DEET_example_data$DEET_gmt_DE
#  message(paste0("DEET_gmt is an object of class gmt?: ",ActivePathways::is.GMT(DEET_gmt) ))
#  
#  ActivePathways::write.GMT(DEET_gmt, file = paste0(tempdir(),"/DEET_DEs.gmt"))
#  
#  

## ----ActivePathways_Direct, eval=FALSE----------------------------------------
#  
#  set.seed(1234) # as I sample p-values to make the toy example
#  
#  
#  
#  # For example two, I had the same genes but I shuffled the p-value
#  
#  example_DEET_enrich_input$padj2 <- sample(example_DEET_enrich_input$padj, length(example_DEET_enrich_input$padj), replace = FALSE)
#  
#  # Make a gene-by-input-list matrix of the adjusted p-values from your multiple gene sets
#  
#  AP_matrix <- as.matrix(example_DEET_enrich_input[,c("padj", "padj2")])
#  
#  # Run activepathways on the combined matrix.
#  
#  # Get gmt file, again from the whole list:
#  
#  DEET_gmt <- DEET_example_data$DEET_gmt_DE
#  
#  head(AP_matrix)
#  
#  AP_example_out <- ActivePathways::ActivePathways(scores=AP_matrix, gmt=DEET_gmt, geneset.filter = c(5,10000),correction.method = "fdr")
#  
#  
#  

