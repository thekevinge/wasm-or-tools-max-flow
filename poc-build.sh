#!/bin/bash

# Make sure we have a 'wasmbuild' folder.
if [ ! -d "wasmpoc" ]; then
    mkdir wasmpoc
fi

# Remove the 'out' folder if it exists.
if [ -d "out" ]; then
    rm -rf out
fi

# In order to find the Emscripten build tools, we need to configure some environment variables so they are available during the build. The required environment variables are initialized by sourcing the 'emsdk_env.sh' that ships with the Emscripten SDK.
pushd emscripten
    echo "Configuring Emscripten environment variables"
    . ./emsdk_env.sh
popd

emcc -O3 \
    --bind \
    -lm \
    -s LLD_REPORT_UNDEFINED \
    -s ERROR_ON_UNDEFINED_SYMBOLS=0 \
    -I wasmbuild/install/include \
    -Lwasmbuild/install/lib \
    -lglog \
    -labsl_bad_any_cast_impl\
    -labsl_log_severity \
    -labsl_bad_optional_access \
    -labsl_malloc_internal \
    -labsl_bad_variant_access\
    -labsl_periodic_sampler \
    -labsl_base \
    -labsl_random_distributions \
    -labsl_city \
    -labsl_random_internal_distribution_test_util \
    -labsl_civil_time\
    -labsl_random_internal_pool_urbg \
    -labsl_cord \
    -labsl_random_internal_randen \
    -labsl_debugging_internal\
    -labsl_random_internal_randen_hwaes \
    -labsl_demangle_internal\
    -labsl_random_internal_randen_hwaes_impl \
    -labsl_dynamic_annotations\
    -labsl_random_internal_randen_slow \
    -labsl_examine_stack\
    -labsl_random_internal_seed_material \
    -labsl_exponential_biased\
    -labsl_random_seed_gen_exception \
    -labsl_failure_signal_handler\
    -labsl_random_seed_sequences \
    -labsl_flags \
    -labsl_raw_hash_set \
    -labsl_flags_config\
    -labsl_raw_logging_internal \
    -labsl_flags_internal \
    -labsl_scoped_set_env \
    -labsl_flags_marshalling\
    -labsl_spinlock_wait \
    -labsl_flags_parse\
    -labsl_stacktrace \
    -labsl_flags_program_name\
    -labsl_status \
    -labsl_flags_registry\
    -labsl_str_format_internal \
    -labsl_flags_usage\
    -labsl_strings \
    -labsl_flags_usage_internal \
    -labsl_strings_internal \
    -labsl_graphcycles_internal \
    -labsl_symbolize \
    -labsl_hash \
    -labsl_synchronization \
    -labsl_hashtablez_sampler\
    -labsl_throw_delegate \
    -labsl_int128\
    -labsl_time \
    -labsl_leak_check\
    -labsl_time_zone \
    -labsl_leak_check_disable \
    -lCbc -lCbcSolver -lCgl -lClp -lClpSolver -lCoinUtils -lgflags_nothreads -lortools -lOsi -lOsiCbc -lOsiClp -lprotobuf -lscip -lz \
    examples/cpp/min_cost_flow.cc \
    -o wasmpoc/min_cost_flow.html \
