#!/usr/bin/env nextflow

params.str = 'Hello world!'

Channel
    .fromList( ['a', 'b', 'c', 'd'] )
    .view { "value: $it" }

process splitLetters {

    output:
    file 'chunk_*' into letters

    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}


process convertToUpper {

    input:
    file x from letters.flatten()

    output:
    stdout result

    """
    rev $x
    """
}

result.view { it.trim() }