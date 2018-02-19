#!/usr/bin/env bats


load environment
load test_helper

@test "options command - all" {
  JAVA_APP_DIR=$RUN_JAVA_DIR run $TEST_SHELL $RUN_JAVA options
  echo $status
  echo $output

  if [ -n "${MEMORY:-}" ]; then
      assert_regexp "-Xmx"
      assert_not_regexp "-Xms"
  fi
  assert_regexp "CICompilerCount"
  assert_status 0
}

@test "options command - memory" {
  JAVA_APP_DIR=$RUN_JAVA_DIR JAVA_INIT_MEM_RATIO=0.5 run $TEST_SHELL $RUN_JAVA options --memory
  echo $status
  echo $output

  if [ -n "${MEMORY:-}" ]; then
      assert_regexp "-Xmx"
      assert_regexp "-Xms"
  fi
  assert_not_regexp "CICompilerCount"
  assert_status 0
}
