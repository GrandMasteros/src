add_test( MsgMergerTest.first /home/cscomarch/embeddedProject/src/build/bin/ut_connectionMgr [==[--gtest_filter=MsgMergerTest.first]==] --gtest_also_run_disabled_tests)
set_tests_properties( MsgMergerTest.first PROPERTIES WORKING_DIRECTORY /home/cscomarch/embeddedProject/src/build/connectionManager/ut)
add_test( MsgMergerTest.sec /home/cscomarch/embeddedProject/src/build/bin/ut_connectionMgr [==[--gtest_filter=MsgMergerTest.sec]==] --gtest_also_run_disabled_tests)
set_tests_properties( MsgMergerTest.sec PROPERTIES WORKING_DIRECTORY /home/cscomarch/embeddedProject/src/build/connectionManager/ut)
set( ut_connectionMgr_TESTS MsgMergerTest.first MsgMergerTest.sec)