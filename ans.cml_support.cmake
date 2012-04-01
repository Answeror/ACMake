include(ans.env)
include(ans.expand_find_package_hints)

# environment variable CML_DIR must be set first
function(cml_support)
    expand_find_package_hints(CML)
    find_package(CML REQUIRED HINTS ${CML_FIND_PACKAGE_HINTS})
    #include_directories(${CML_INCLUDE_DIRS})
    include(${CML_USE_FILE})
    add_definitions(
        -DCML_VECTOR_UNROLL_LIMIT=25
        -DCML_VECTOR_DOT_UNROLL_LIMIT=25
        -DCML_NO_2D_UNROLLER
        -DCML_DEFAULT_ARRAY_LAYOUT=cml::col_major
        -DCML_ALWAYS_PROMOTE_TO_DEFAULT_LAYOUT
        -DCML_DEFAULT_ARRAY_ALLOC=std::allocator<void>
        -DCML_AUTOMATIC_VECTOR_RESIZE_ON_ASSIGNMENT
        -DCML_CHECK_VECTOR_EXPR_SIZES
        -DCML_AUTOMATIC_MATRIX_RESIZE_ON_ASSIGNMENT
        -DCML_CHECK_MATRIX_EXPR_SIZES
        )
endfunction()
