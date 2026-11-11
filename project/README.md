# Remote Sensing of the Environment Project

## Project Overview:

The data products used for this projects are:

- MODIS - MCD64A1 Burned Area
- Sentinel 1 GRD imagery with VV and VH polarisation

The study area is located in the Llanos de Moxos savannas in Beni, northern Bolivia,
defined by the following bounding box:

- minimum and maximum latitude [-15, -13]
- minimum and maximum longitude [-66, -64]

## Data Acquisition

### MODIS Burning Events Observation

MODIS MCD64A1 data has been downloaded through the NASA's `earthdata` API.

Acquire Sentinel 1 GRD imagery from Copernicus Data Portal, (https://browser.dataspace.copernicus.eu/)

### Copernicus Data portal exploration

Switch acquisition mode to IW (Interferometric Wide Swath), and polarization `VV+VH`.

Set area of to Beni box: **west −66°, south −15°, east −64°, north −13°.**

Start with August-October 2020 as a candidate period.

## Workflow
