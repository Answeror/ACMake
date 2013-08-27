if(ACMAKE_TARGET_ARCH_INCLUDED)
    return()
endif()
set(ACMAKE_TARGET_ARCH_INCLUDED TRUE)

include(TargetArch)

macro(acmake_target_arch result)
    target_architecture(${result})
endmacro()
