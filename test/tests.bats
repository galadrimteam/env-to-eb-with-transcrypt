#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
    ENV_FILE="temp_env_file"
    CONFIG_FILE="temp_config_file"
}

teardown() {
    rm -f "$ENV_FILE" "$CONFIG_FILE"
}

@test "Empty File Test" {
    touch "$ENV_FILE"
    bash generate-eb-env.sh "$ENV_FILE" "$CONFIG_FILE"
    assert_equal "$(cat "$CONFIG_FILE")" $'option_settings:\n  aws:elasticbeanstalk:application:environment:'
}

@test "All Comments Test" {
    {
        echo "# This is a comment"
        echo "# Another comment line"
    } >"$ENV_FILE"
    bash generate-eb-env.sh "$ENV_FILE" "$CONFIG_FILE"
    assert_equal "$(cat "$CONFIG_FILE")" $'option_settings:\n  aws:elasticbeanstalk:application:environment:'
}

@test "Mixed Content Test" {
    {
        echo "# Comment line"
        echo "VAR1=value1"
        echo "# Another comment"
        echo ""
        echo "VAR2=value2"
    } >"$ENV_FILE"
    bash generate-eb-env.sh "$ENV_FILE" "$CONFIG_FILE"
    assert_equal "$(cat "$CONFIG_FILE")" $'option_settings:\n  aws:elasticbeanstalk:application:environment:\n    VAR1: value1\n    VAR2: value2'
}

@test "No comments Test" {
    {
        echo "VAR1=value1"
        echo "VAR2=value2"
    } >"$ENV_FILE"
    bash generate-eb-env.sh "$ENV_FILE" "$CONFIG_FILE"
    assert_equal "$(cat "$CONFIG_FILE")" $'option_settings:\n  aws:elasticbeanstalk:application:environment:\n    VAR1: value1\n    VAR2: value2'
}
