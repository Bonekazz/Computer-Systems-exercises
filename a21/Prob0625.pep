            BR          main

;--------- void times(int *prod, int mpr, int mcand)

mcand:      .EQUATE     2                   ;formal #2d
mpr:        .EQUATE     4                   ;formal #2d
prod:       .EQUATE     6                   ;formal #2d

times:      LDWA        0,          i 
            STWA        prod,       sf
while:      LDWA        mpr,        s       ;while (mpr != 0)
            CPWA        0,          i
            BREQ        endWhile 
if:         LDWA        mpr,        s       ;if (mpr % 2 == 1)
            RORA        
            BRC         contIf
            BR          endIf

contIf:     LDWA        prod,       sf      ;*prod += mcand
            ADDA        mcand,      s 
            STWA        prod,       sf

endIf:      LDWA        mpr,        s       ;mpr /= 2 
            ASRA
            STWA        mpr,        s
            LDWA        mcand,      s       ;mcand *= 2
            ASLA        
            STWA        mcand,      s
            BR          while      

endWhile:   RET

;--------- int main()

product:    .EQUATE      0                   ;local variable #2d
n:          .EQUATE      2                   ;local variable #2d
m:          .EQUATE      4                   ;local variable #2d

main:       SUBSP       6,          i       ;push #m #n #product
            DECI        n,          s
            DECI        m,          s 
            MOVSPA                          ;move &product
            STWA        -2,         s
            LDWA        n,          s
            STWA        -4,         s
            LDWA        m,          s 
            STWA        -6,         s
            SUBSP       6,          i       ;push #prod #mpr #mcand
            CALL        times
            ADDSP       6,          i       ;pop #mcand #mpr #prod 
            STRO        msgMain,    d       ;printf("Product: %d\n", product);
            DECO        product,    s
            ADDSP       6,          i       ;pop #product #n #m
            LDBA        '\n',       i 
            STBA        charOut,    d
            STOP 
msgMain:    .ASCII      "Product: \x00"
            .END