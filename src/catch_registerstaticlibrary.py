"""
Utility python functions in order to create automatic registration function helpers
This script is called by registerstaticlibrary.cmake
"""
#!/bin/python
import sys
import uuid
import os.path
import re

REGISTERCPPFILE_CODE = """
// This code was added by rsl_registerstaticlibrary.cmake in order to ensure that the tests are properly run.
// Please commit it if needed, it will be added only once, and never modified.
// Before committing, you can remove this comment, as long as you leave the function below.
int RslRegister_GUID() { return 0; }
"""

REGISTERMAINFILE_CODE = """
// This file is autogenerated.
// It was added by rsl_registerstaticlibrary.cmake in order to ensure that the tests are properly run.
// Please commit it if needed, it will be modified only if new files are added.

[DeclareRegisterFunctions]

int RslRegisterStaticLibrary()
{
  int dummy_sum = 0;
[CallRegisterFunctions]
  return dummy_sum;
}
"""

REGISTERMAINFILE_NAME = "rsl_registerstaticlibrary.cpp"

KNOWN_CPP_EXTENSIONS = ["cpp", "cc", "cxx", "c++", "CPP", "CC", "CXX", "C++"]

def findwholeword_regex(word):
    """creates a regex that matches a word"""
    return re.compile(r'\b({0})\b'.format(word)).search

# words that indicate that a file actually implements tests (using catch for example)
CPP_TESTFILE_HINTS = ["catch.hpp", "TEST_CASE", "SCENARIO"]

def does_sourcefile_implement_tests(lines):
    """Checks if a cpp file seems to implement tests"""
    test_usage_found = False
    for line in lines:
        line = line[:-1]
        # print("testing line ==>" + line + "<==")
        for test_usage_hint in CPP_TESTFILE_HINTS:
            my_regex = findwholeword_regex(test_usage_hint)
            if my_regex(line):
                test_usage_found = True
                # print("Match with " + test_usage_hint)
        if test_usage_found:
            break
    # print("test_usage_found=" + str(test_usage_found))
    return test_usage_found

def register_one_cpp_file(filename):
    """Modifies a cpp file by adding REGISTERCPPFILE_CODE (if needed)"""
    # print("register_one_cpp_file " + filename)
    if filename == REGISTERMAINFILE_NAME:
        return

    file_extension = filename.split(".")[-1]
    if not file_extension in KNOWN_CPP_EXTENSIONS:
        return

    with open(filename, 'r') as f:
        lines = f.readlines()

    if not does_sourcefile_implement_tests(lines):
        return

    already_registered = False
    for line in lines:
        if "int RslRegister_" in line:
            already_registered = True

    if not already_registered:
        thisfile_guid = str(uuid.uuid4()).replace("-", "_")
        with open(filename, 'a') as f:
            code_with_uuid = REGISTERCPPFILE_CODE.replace("GUID", thisfile_guid)
            f.write(code_with_uuid)
            print(filename + " was modified (added RslRegister_ function()")


def register_cpp_files(source_files):
    """Registers all source files"""
    for filename in source_files:
        register_one_cpp_file(filename)

def find_cpp_file_register_guid(cpp_filename):
    """Finds the registration guid in a cpp file"""
    guid = ""
    with open(cpp_filename, 'r') as file_handle:
        lines = file_handle.readlines()
    for line in lines:
        if "int RslRegister_" in line:
            line = line.replace("int", "").replace("(", "").replace(")", "")
            words = line.split()
            for word in words:
                if "RslRegister_" in word:
                    guid = word.replace("RslRegister_", "")
    return guid

def register_main_file(source_files):
    """Creates the main cpp registration file"""
    guid_list = []
    for filename in source_files:
        file_extension = filename.split(".")[-1]
        if not file_extension in KNOWN_CPP_EXTENSIONS:
            continue
        guid = find_cpp_file_register_guid(filename)
        if guid != "":
            guid_list.append(guid)

    declare_register_functions_code = ""
    call_register_functions_code = ""
    for guid in guid_list:
        declare_register_functions_code += "int RslRegister_" + guid + "();\n"
        call_register_functions_code += "  dummy_sum += RslRegister_" + guid + "();\n"

    registermainfile_code = REGISTERMAINFILE_CODE
    registermainfile_code = registermainfile_code.replace(
        "[DeclareRegisterFunctions]", declare_register_functions_code)
    registermainfile_code = registermainfile_code.replace(
        "[CallRegisterFunctions]", call_register_functions_code)
    #print(registermainfile_code)

    if not os.path.isfile(REGISTERMAINFILE_NAME):
        print(REGISTERMAINFILE_NAME + " was created (you can add it to source control, or ignore it, as preferred)")
    with open(REGISTERMAINFILE_NAME, "w") as file_handle:
        file_handle.write(registermainfile_code)


def show_help():
    """Show help"""
    help_message = """
        Usage :
            _command_ -rsl_registercppfiles file1.cpp file2.cpp ...
                Will add a RslRegister_GUID() to cpp files
            _command_ -registermainfile file1.cpp file2.cpp file3.cpp ...
                Will create a the main register file with one function that calls all RslRegister_GUID() functions
    """
    help_message = help_message.replace("_command_", sys.argv[0])
    print(help_message)

def main():
    """Main entry point"""
    if len(sys.argv) < 2:
        show_help()
        exit(1)
    if sys.argv[1] == "-rsl_registercppfiles":
        files = sys.argv[2:]
        register_cpp_files(files)
    elif sys.argv[1] == "-registermainfile":
        files = sys.argv[2:]
        register_main_file(files)
    else:
        help()

main()
