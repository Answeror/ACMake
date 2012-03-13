function(ans_support TARGET)
    find_package(Ans REQUIRED)
    include_directories(${ANS_INCLUDE_DIRS})
endfunction()
