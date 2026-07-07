#!/bin/bash

set -e

CONFIG_FILE="../../config/config.yaml"
RESULTS_DIR="../../results"

if ! command -v yq &> /dev/null; then
  echo "Error: 'yq' not found. Install it with 'conda install -c conda-forge yq'"
  exit 1
fi

echo "Reading config from $CONFIG_FILE"

# Load files
BIGWIGS=($(yq '.deeptools.files.bigwigs[]' "$CONFIG_FILE"))
for i in "${!BIGWIGS[@]}"; do
  BIGWIGS[$i]="$RESULTS_DIR/${BIGWIGS[$i]}"
done

SUMMARY_BW="$RESULTS_DIR/$(yq '.deeptools.files.summary_bw' "$CONFIG_FILE")"
GENE_BED="$RESULTS_DIR/$(yq '.deeptools.files.gene_regions_bed' "$CONFIG_FILE")"
PEAKS_BED="$RESULTS_DIR/$(yq '.deeptools.files.chip_peaks_bed' "$CONFIG_FILE")"

# Outputs (write into results/)
MATRIX_OUT="$RESULTS_DIR/$(yq '.deeptools.output.matrix' "$CONFIG_FILE")"
HEATMAP_OUT="$RESULTS_DIR/$(yq '.deeptools.output.heatmap_svg' "$CONFIG_FILE")"
SORTED_REGIONS="$RESULTS_DIR/$(yq '.deeptools.output.heatmap_bed' "$CONFIG_FILE")"
PROFILE_OUT="$RESULTS_DIR/$(yq '.deeptools.output.profile_svg' "$CONFIG_FILE")"
SUMMARY_NPZ="$RESULTS_DIR/$(yq '.deeptools.output.summary_npz' "$CONFIG_FILE")"
SUMMARY_TAB="$RESULTS_DIR/$(yq '.deeptools.output.summary_tab' "$CONFIG_FILE")"

# Parameters
BODY_LENGTH=$(yq '.deeptools.parameters.region_body_length' "$CONFIG_FILE")
UPSTREAM=$(yq '.deeptools.parameters.upstream' "$CONFIG_FILE")
DOWNSTREAM=$(yq '.deeptools.parameters.downstream' "$CONFIG_FILE")
BIN_SIZE=$(yq '.deeptools.parameters.bin_size' "$CONFIG_FILE")
HEATMAP_WIDTH=$(yq '.deeptools.parameters.heatmap_width' "$CONFIG_FILE")
HEATMAP_HEIGHT=$(yq '.deeptools.parameters.heatmap_height' "$CONFIG_FILE")
PROFILE_WIDTH=$(yq '.deeptools.parameters.profile_width' "$CONFIG_FILE")
PROFILE_HEIGHT=$(yq '.deeptools.parameters.profile_height' "$CONFIG_FILE")
COLORMAP=$(yq '.deeptools.parameters.color_map' "$CONFIG_FILE")
LEGEND=$(yq '.deeptools.parameters.legend_location' "$CONFIG_FILE")
PROFILE_TITLE=$(yq '.deeptools.parameters.profile_title' "$CONFIG_FILE")

# Labels and colors
LABELS=($(yq '.deeptools.labels.samples[]' "$CONFIG_FILE"))
COLORS=($(yq '.deeptools.parameters.profile_colors[]' "$CONFIG_FILE"))

echo "Running computeMatrix..."
computeMatrix scale-regions \
  -S "${BIGWIGS[@]}" \
  -R "$GENE_BED" \
  --regionBodyLength "$BODY_LENGTH" -b "$UPSTREAM" -a "$DOWNSTREAM" \
  --binSize "$BIN_SIZE" \
  -out "$MATRIX_OUT" \
  --samplesLabel "${LABELS[@]}"

echo "Plotting heatmap..."
plotHeatmap \
  -m "$MATRIX_OUT" \
  --colorMap "$COLORMAP" \
  --heatmapHeight "$HEATMAP_HEIGHT" \
  --heatmapWidth "$HEATMAP_WIDTH" \
  --samplesLabel "${LABELS[@]}" \
  --outFileName "$HEATMAP_OUT" \
  --outFileSortedRegions "$SORTED_REGIONS"

echo "Plotting profile..."
plotProfile \
  -m "$MATRIX_OUT" \
  --samplesLabel "${LABELS[@]}" \
  --outFileName "$PROFILE_OUT" \
  --plotTitle "$PROFILE_TITLE" \
  --legendLocation "$LEGEND" \
  --colors "${COLORS[@]}" \
  --perGroup \
  --plotHeight "$PROFILE_HEIGHT" \
  --plotWidth "$PROFILE_WIDTH"

echo "Summarizing peaks..."
multiBigwigSummary BED-file \
  --bwfiles "$SUMMARY_BW" \
  --BED "$PEAKS_BED" \
  -out "$SUMMARY_NPZ" \
  --outRawCounts "$SUMMARY_TAB"

echo "✅ All done. Outputs saved in $RESULTS_DIR"
