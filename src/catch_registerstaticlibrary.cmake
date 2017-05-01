if(NOT DEFINED catch_lib_location)
  message("")
  message("Please define catch_lib_location with the location of the folder containing catch.hpp")
  message("For example:")
  message("set (catch_lib_location ${CMAKE_SOURCE_DIR}/catch)")
  message("")
  message(FATAL_ERROR "Please define catch_lib_location)")
endif()

set (catch_registerstaticlibrary_location ${CMAKE_CURRENT_LIST_DIR})

if (MSVC)
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

function (rsl_registercppfiles libraryName)
  get_target_property(sources ${libraryName} SOURCES)
  # rsl_registercppfiles is a dependency of the library, so that
  # it will be called during the build
  add_custom_target(registercppfiles_${libraryName} COMMAND python ${catch_registerstaticlibrary_location}/catch_registerstaticlibrary.py -rsl_registercppfiles ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  add_dependencies(${libraryName} registercppfiles_${libraryName})
  set_target_properties(registercppfiles_${libraryName} PROPERTIES FOLDER catch_autoregister)
endfunction()

function (rsl_registermainfile libraryName)
  get_target_property(sources ${libraryName} SOURCES)

  # execute_process is executed during cmake : this is important, otherwise
  # the first cmake might fail if the file catch_registerstaticlibrary.cpp
  # was not yet created
  execute_process(COMMAND python ${catch_registerstaticlibrary_location}/catch_registerstaticlibrary.py -registermainfile ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

  # Also execute this step during the build
  add_custom_target(registermainfile_${libraryName} COMMAND python ${catch_registerstaticlibrary_location}/catch_registerstaticlibrary.py -registermainfile ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  add_dependencies(${libraryName} registermainfile_${libraryName})
  set_target_properties(registermainfile_${libraryName} PROPERTIES FOLDER catch_autoregister)

  if(TARGET registercppfiles_${libraryName})
    add_dependencies(registermainfile_${libraryName} registercppfiles_${libraryName})
  endif()
endfunction()


function (rsl_addincludepath libraryName)
  target_include_directories(${libraryName} PUBLIC ${catch_lib_location} )
endfunction()


function (rsl_appendregistermainfiletosources libraryName)
  get_target_property(sources ${libraryName} SOURCES)

  # append catch_registerstaticlibrary.cpp to the library sources if needed
  if (NOT ";${SOURCES};" MATCHES ";catch_registerstaticlibrary.cpp;")
    set(sourcesWithRegistercatch ${SOURCES} catch_registerstaticlibrary.cpp)
    target_sources(${libraryName} PRIVATE ${sourcesWithRegistercatch})
  endif()
endfunction()

function (rsl_maketesttarget libraryName testTargetName)
  add_executable(${testTargetName} ${catch_registerstaticlibrary_location}/catch_main.cpp)
  target_link_libraries(${testTargetName} ${libraryName})

  # place the test target in the same msvc solution folder
  get_target_property(msvc_folder_testtarget ${testTargetName} FOLDER)
  if (${msvc_folder_testtarget} MATCHES ".*NOTFOUND")
    get_target_property(msvc_folder ${libraryName} FOLDER)
    if (NOT ${msvc_folder} MATCHES ".*NOTFOUND")
      set_target_properties(${testTargetName} PROPERTIES FOLDER ${msvc_folder})
    endif()
  endif()
endfunction()

function (rsl_registercmaketest testTargetName)
  add_test(NAME ${testTargetName} COMMAND ${testTargetName})
endfunction()


function (catch_registerstaticlibrary libraryName testTargetName)
  # message("catch_register_static_library " ${libraryName})
  rsl_addincludepath(${libraryName})
  rsl_registercppfiles(${libraryName})
  rsl_registermainfile(${libraryName})
  rsl_appendregistermainfiletosources(${libraryName})

  rsl_maketesttarget(${libraryName} ${testTargetName})
  rsl_registercmaketest(${testTargetName})
endfunction()
