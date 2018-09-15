function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function getColorBrightness(r,g,b)
  r = r/255
  g = g/255
  b = b/255 
  return (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
end

function changeColorBrightness(r,g,b,amnt)

    if amnt < 0 then
        amnt = 1 + amnt
        r = r * amnt
        b = b * amnt
        g = g * amnt
    else
        r = (255-r) * amnt + r
        g = (255-g) * amnt + g
        b = (255-b) * amnt + b    
    end
    return r,g,b
end