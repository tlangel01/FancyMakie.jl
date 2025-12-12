module FancyMakie
__precompile__()

using CairoMakie, LaTeXStrings

const fg_theme = Theme(size = (453.54,340.15), fontsize = 12)
const ax_theme = Theme(Axis = (   
    xminorticks = IntervalsBetween(2),
    yminorticks = IntervalsBetween(2),
    xtickalign = 1,
    ytickalign = 1,
    xticksize = 4,
    yticksize = 4,
    xminortickalign = 1,
    yminortickalign = 1,
    xminorticksize = 2.5,
    yminorticksize = 2.5,
    xticksmirrored=true,
    yticksmirrored=true,
    xminorticksvisible = true,
    yminorticksvisible = true,
    xgridvisible = false,
    ygridvisible = false,
    xminorgridvisible = false,
    yminorgridvisible = false
))
const lb_theme = Theme(Label = (valign = :top, halign = :left, padding = (5,5,5,5)))
const eb_theme = Theme(Errorbars = (whiskerwidth = 5, linewidth = 1))
const lg_theme = Theme(Legend = (position = :rt, margin = (1,1,1,1), framevisible=false, rowgap=-5, merge=true))
const plot_theme = merge(fg_theme, ax_theme, lg_theme, eb_theme, lb_theme)

const ax_theme_map = Theme(Axis = (   
    xminorticks = IntervalsBetween(2),
    yminorticks = IntervalsBetween(2),
    xtickalign = 0,
    ytickalign = 0,
    xticksize = 4,
    yticksize = 4,
    xminortickalign = 0,
    yminortickalign = 0,
    xminorticksize = 2.5,
    yminorticksize = 2.5,
    xminorticksvisible = true,
    yminorticksvisible = true,
    xgridvisible = false,
    ygridvisible = false,
    xminorgridvisible = false,
    yminorgridvisible = false
))
const cb_theme = Theme(Colorbar = (vertical=true, flipaxis=true))
const heatmap_theme = merge(fg_theme, ax_theme_map)

function set_custom_theme!(theme::Symbol=:plot)
    if theme === :plot
        custom_theme = plot_theme
    elseif theme === :heatmap
        custom_theme = heatmap_theme
    else
        error("$theme not defined; try :plot or :heatmap")
    end
    Makie.set_screen_config!(CairoMakie, (px_per_unit=8,pt_per_unit=1))
    @eval Makie begin # make line and Marker elements of uniform size
        set_theme!(merge($custom_theme, theme_latexfonts()))
        function legendelements(plot::Lines, legend)
            return LineElement(
                color = plot.color[],
                linewidth = 1,
                linestyle = plot.linestyle[],
                points = [Point2f(0, 0.5), Point2f(1, 0.5)]
            )
        end
        
        function legendelements(plot::Stairs, legend)
            return LineElement(
                color = plot.color[],
                linewidth = 1,
                linestyle = plot.linestyle[],
                points = [Point2f(0, 0.5), Point2f(1, 0.5)]
            )
        end
        
        function legendelements(plot::Scatter, legend)
            return MarkerElement(
                color = plot.color[],
                marker = plot.marker,
                markersize = 5
            )
        end
        
        # make legendelement for errorbars actually errorbars (courtesy of ChatGPT)
        function legendelements(plot::Errorbars, legend)
            w = 1.0   # horizontal bar length
            h = 0.2   # whisker height
        
            # Define points centered at (0,0)
            points = Point2f[
                (-w/2,  h/2), (-w/2, -h/2),   # left whisker
                (-w/2,   0),  ( w/2,   0),    # horizontal bar
                ( w/2,  h/2), ( w/2, -h/2)    # right whisker
            ]
            # Shift all points so the glyph is centered at (0.5,0.5)
            points .= points .+ Point2f(0.5, 0.5)
        
            return LineElement(
                color = plot.color[],
                linewidth = 1,
                points = points,
            )
        end
    end
end

mm2pt(x,y) = 2.83465 .* (x,y)
comma(str)=replace(str,'.'=>',')
wbox(ax,limits)=poly!(ax,Point2f[(limits[1],limits[3]),(limits[2],limits[3]),(limits[2],limits[4]),(limits[1],limits[4])],
space=:relative,color=:white,strokewidth=0.6,strokecolor=:black,linestyle=:solid)


function cross(;length=1,width=1,rotation=0)
    l=0.5length
    w=0.12width
    α=rotation
    BezierPath([
    MoveTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  0,  w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(l-w,  l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  l,l-w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  w,  0)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  l,w-l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(l-w, -l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  0, -w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(w-l, -l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point( -l,w-l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point( -w,  0)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point( -l,l-w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(w-l,  l)),
    ClosePath()
    ])
end

export set_custom_theme!, mm2pt, comma, wbox

end # module