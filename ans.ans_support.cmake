include(acmake_common)

function(ans_support)
    find_package(Ans REQUIRED)
    include_directories(${ANS_INCLUDE_DIRS})
endfunction()
