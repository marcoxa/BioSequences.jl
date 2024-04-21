### -*- Mode: Julia -*-

### in_module.jl
###
### Some - you guessed it - Common Lisp inspired utilities.
###
### See the file COPYING in the main directory (or folder, or PDS)
### for copyright and licensing information.
###
### Notes:
###
### Julia macros are almost what you want; alas they use the ugly `@`
### thingie.  Oh, well.


export @in_module


"""
        @in_module m

Simple macro that can be used to warn you if you try to `include` a
file while not in the expected module.  It is also useful for
self-documentation, non comment, purposes.
"""
macro in_module(m)
    quote
        let modexpr = $(esc(m))
            if ! isa(modexpr,  Module)
                @warn string(modexpr, " is not a Module.")
                false
            elseif modexpr == @__MODULE__
                true
            else
                @warn string("in module ", @__MODULE__,
                             ", not ", modexpr, ".")
                false
            end
        end
    end
end


### in_module.jl ends here.
