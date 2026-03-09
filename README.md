# FancyMakie.jl

FancyMakie is a small package i wrote as a template or config to plot with.

## Setup

Install via

```julia
] add https://github.com/otorias/FancyMakie.jl.git
```
Then use with

```julia
using FancyMakie
```

## Getting Started

### Theme

The predefined theme can be set with:

```julia
set_custom_theme!()
```

This function also takes two optional argument:
- The first is to set it to the normal plot-mode or heatmap-mode: `:plot`, `:heatmap`.
- The second is to choose the font style. Currently implemented are `:latex` and `:utopia` for Computer Modern (standard) and Utopia (Erewhon), respectively. Utopia also supports `U"\\othergreek"` syntax to render roman (upright) greek letters.

Most importantly this theme uses LaTeXfonts and includes an (imo) better way to represent errorbars in the legend, while also setting all linewidths in the legend to the same value to prevent the issue that too thin lines are barely visible in the legend.

### Figure size

To create ready-to-publish figures, the size and fontsize should be normalized.
For this the abovementioned theme defaults to a fontsize of 12 px with a size of 16 x 12 cm.
To change the size of a figure you can set it via `mm2pt(width,height)`, e.g., to 14 x 14 cm with:
```julia
fig = Figure(size = mm2pt(140,140), fontsize=14)
```

### Other

Other functionalities are not as important and can be found with
```julia
? FancyMakie
```
