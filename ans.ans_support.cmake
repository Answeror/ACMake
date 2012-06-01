include(ans.env)
include(ans.expand_find_package_hints)

function(ans_support)
    expand_find_package_hints(Ans)
    find_package(Ans REQUIRED HINTS ${Ans_FIND_PACKAGE_HINTS})
    include_directories(${ANS_INCLUDE_DIRS})
endfunction()
