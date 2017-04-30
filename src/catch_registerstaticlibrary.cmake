# Adjust this path if needed : this is where your catch.hpp file resides 
set (catch_lib_location ${CMAKE_SOURCE_DIR}/catch)
# Adjust this path if needed : this is where a checkout of catch_registerstaticlibrary resides
set (catch_registerstaticlibrary_location ${CMAKE_SOURCE_DIR}/catch_registerstaticlibrary)

function (catch_registercppfiles libraryName)
  get_target_property(sources ${libraryName} SOURCES)
  # catch_registercppfiles is a dependency of the library, so that
  # it will be called during the build
  add_custom_target(catch_registercppfiles_${libraryName} COMMAND python ${catch_registerstaticlibrary_location}/src/catch_registerstaticlibrary.py -registercppfiles ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  add_dependencies(${libraryName} catch_registercppfiles_${libraryName})
  set_target_properties(catch_registercppfiles_${libraryName} PROPERTIES FOLDER _catch)
endfunction()

function (catch_create_registermainfile libraryName)
  get_target_property(sources ${libraryName} SOURCES)

  # execute_process is executed during cmake : this is important, otherwise
  # the first cmake might fail if the file catch_registerstaticlibrary.cpp
  # was not yet created
  execute_process(COMMAND python ${catch_registerstaticlibrary_location}/src/catch_registerstaticlibrary.py -registermainfile ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

  # Also execute this step during the build
  add_custom_target(catch_create_registermainfile${libraryName} COMMAND python ${catch_registerstaticlibrary_location}/src/catch_registerstaticlibrary.py -registermainfile ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  add_dependencies(${libraryName} catch_create_registermainfile${libraryName})
  set_target_properties(catch_create_registermainfile${libraryName} PROPERTIES FOLDER _catch)

  if(TARGET catch_registercppfiles_${libraryName})
    add_dependencies(catch_create_registermainfile${libraryName} catch_registercppfiles_${libraryName})
  endif()
endfunction()


function (catch_addincludepath libraryName)
  target_include_directories(${libraryName} PUBLIC ${catch_lib_location} )
endfunction()


function (catch_appendregisterlibrarycpp_tosources libraryName)
  get_target_property(sources ${libraryName} SOURCES)

  # append catch_registerstaticlibrary.cpp to the library sources if needed
  if (NOT ";${SOURCES};" MATCHES ";catch_registerstaticlibrary.cpp;")
    set(sourcesWithRegistercatch ${SOURCES} catch_registerstaticlibrary.cpp)
    target_sources(${libraryName} PRIVATE ${sourcesWithRegistercatch})
  endif()
endfunction()

function (catch_maketesttarget libraryName testTargetName)
  add_executable(${testTargetName} ${catch_registerstaticlibrary_location}/src/catch_main.cpp)
  target_link_libraries(${testTargetName} ${libraryName})
endfunction()

function (catch_register_ctest testTargetName)
  add_test(NAME ${testTargetName} COMMAND ${testTargetName})
endfunction()


function (catch_registerstaticlibrary libraryName testTargetName)
  # message("catch_register_static_library " ${libraryName})
  catch_addincludepath(${libraryName})
  catch_registercppfiles(${libraryName})
  catch_create_registermainfile(${libraryName})
  catch_appendregisterlibrarycpp_tosources(${libraryName})

  catch_maketesttarget(${libraryName} ${testTargetName})
  catch_register_ctest(${testTargetName})
endfunction()
