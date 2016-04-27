" Collection of Tabular Macros
"
if !exists(':Tabularize')
    finish 
endif

" fc = first colon; used to format JSON files
AddTabularPattern! fc /^[^:]*\zs:/l2l1l0
