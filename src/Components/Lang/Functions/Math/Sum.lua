return {
    name = "sum",
    run = function(_val1, _val2)
        ram.buffer[5] = _val1 + _val2
    end
}