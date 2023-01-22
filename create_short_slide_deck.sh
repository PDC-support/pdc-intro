#!/bin/bash

# Use the pdftk program to concatenate a selection of slides to a shorter slidedeck
pdftk PITCHME.pdf cat 1 4 6 5 8 10 12-16 20-33 71-81 94-106 109-110 output pdc-intro-short.pdf
