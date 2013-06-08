if(ACMAKE_TARGET_PROPERTY_INCLUDED)
    return()
endif()
set(ACMAKE_TARGET_PROPERTY_INCLUDED TRUE)

include(acmake_assert)

macro(acmake_append_target_property TARGET KEY)
    get_target_property(_ACMAKE_APPEND_TARGET_PROPERTY_VALUE ${TARGET} ${KEY})
    if(NOT _ACMAKE_APPEND_TARGET_PROPERTY_VALUE)
        set(_ACMAKE_APPEND_TARGET_PROPERTY_VALUE)
    endif()
    list(APPEND _ACMAKE_APPEND_TARGET_PROPERTY_VALUE ${ARGN})
    set_target_properties(
        ${TARGET}
        PROPERTIES
        ${KEY} "${_ACMAKE_APPEND_TARGET_PROPERTY_VALUE}"
        )
endmacro()

macro(acmake_get_target_property OUTPUT TARGET KEY)
    get_target_property(${OUTPUT} ${TARGET} ${KEY})
    if(NOT ${OUTPUT})
        set(${OUTPUT})
    endif()
endmacro()
