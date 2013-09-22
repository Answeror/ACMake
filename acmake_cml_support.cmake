if(ACMAKE_CML_SUPPORT_INCLUDED)
    return()
else()
    set(ACMAKE_CML_SUPPORT_INCLUDED TRUE)
endif()

include(acmake_common)
include(acmake_find_package)

function(acmake_cml_support TARGET)
    acmake_find_package(CML REQUIRED)
    include(${CML_USE_FILE})
    target_compile_definitions(
        ${TARGET}
        PUBLIC
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
    target_include_directories(${TARGET} PUBLIC ${CML_HEADER_PATH})
endfunction()
