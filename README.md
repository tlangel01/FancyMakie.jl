# FancyMakie.jl

FancyMakie is a small package i wrote as a template or config to plot with.

## Setup

Install via

```julia
julia>]
pkg> add https://github.com/tlangel01/FancyMakie.jl.git
```
Then use with

```julia
julia> using FancyMakie
```

## Getting Started

### Theme

The predefined theme can be set with:

```julia
julia> set_custom_theme!()
```

This function also takes an optional argument to set to heatmap-mode: `:heatmap`.

Most importantly this theme uses LaTeXfonts and includes a (imo) better way to represent errorbars in the legend, while also setting all linewidths in the legend to the same value to prevent the issue that too thin lines are barely visible in the legend.

### Figure size

To create ready-to-publish figures, the size and fontsize should be normalized.
For this the abovementioned theme defaults to a fontsize of $12\ \mathrm{px}$ with a size of $16\times12\ \mathrm{cm}$.
To change the size of a figure you can set it via `mm2pt(width,height)`, *e.g.,* to $14\times14\ \mathrm{cm} with:
```julia
julia> fig = Figure(size = mm2pt(140,140), fontsize=14)
```

### Other

Other functionalities are not as important and can be found with
```julia
julia>?
help?> FancyMakie
```
