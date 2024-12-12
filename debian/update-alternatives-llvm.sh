#!/bin/bash
#
# add clang ${version} to Debian/Ubuntu
# https://gist.github.com/junkdog/70231d6953592cd6f27def59fe19e50d?permalink_comment_id=4336074#gistcomment-4336074

update_alternatives() {
    local version=${1}
    local priority=${2}
    local master=${3}
    local slaves=${4}
    local path=${5}
    local cmdln

    cmdln="--verbose --install ${path}${master} ${master} ${path}${master}-${version} ${priority}"
    for slave in ${slaves}; do
        cmdln="${cmdln} --slave ${path}${slave} ${slave} ${path}${slave}-${version}"
    done
     update-alternatives ${cmdln}
}


if [[ ${#} -ne 2 ]]; then
    echo usage: "${0}" clang_version priority
    exit 1
fi

version=${1}
priority=${2}
path="/usr/bin/"

#  apt update

# download and launch the setup script
# wget https://apt.llvm.org/llvm.sh
#  bash llvm.sh ${version}
# bash llvm.sh ${version} all

# configure with update-alternatives
master="llvm-config"
slaves="llvm-addr2line llvm-ar llvm-as llvm-bcanalyzer llvm-bitcode-strip llvm-cat llvm-cfi-verify llvm-cov llvm-c-test llvm-cvtres llvm-cxxdump llvm-cxxfilt llvm-cxxmap llvm-debuginfo-analyzer llvm-debuginfod llvm-debuginfod-find llvm-diff llvm-dis llvm-dlltool llvm-d
warfdump llvm-dwarfutil llvm-dwp llvm-exegesis llvm-extract llvm-gsymutil llvm-ifs llvm-install-name-tool llvm-jitlink llvm-jitlink-executor llvm-lib llvm-libtool-darwin llvm-link llvm-lipo llvm-lto llvm-lto2 llvm-mc llvm-mca llvm-ml llvm-modextract llvm-mt llvm-nm llv
m-objcopy llvm-objdump llvm-opt-report llvm-otool llvm-pdbutil llvm-PerfectShuffle llvm-profdata llvm-profgen llvm-ranlib llvm-rc llvm-readelf llvm-readobj llvm-reduce llvm-remark-size-diff llvm-remarkutil llvm-rtdyld llvm-sim llvm-size llvm-split llvm-stress llvm-stri
ngs llvm-strip llvm-symbolizer llvm-tapi-diff llvm-tblgen llvm-tli-checker llvm-undname llvm-windres llvm-xray"

update_alternatives "${version}" "${priority}" "${master}" "${slaves}" "${path}"

master="clang"
slaves="asan_symbolize bugpoint clang++ clang-cpp clangd count dsymutil FileCheck ld64.lld ld.lld llc lld lldb lldb-argdumper lldb-instr lldb-server lldb-vscode lld-link lli lli-child-target not obj2yaml opt sanstats split-file UnicodeNameMappingGenerator verify-uselis
torder wasm-ld yaml2obj yaml-bench"

update_alternatives "${version}" "${priority}" "${master}" "${slaves}" "${path}"

# to uninstall a Clang version
# LLVM_VERSION=12
#  apt purge -y clang-${LLVM_VERSION} lldb-${LLVM_VERSION} lld-${LLVM_VERSION} clangd-${LLVM_VERSION} &&  apt autoremove -y

# to generate the list of slaves on a clean vm
# 0.  apt update &&  apt full-upgrade -y &&  apt autoremove -y &&  apt autoclean
# 1. ls /usr/bin > usr_bin_orig
# 2. install the new version of clang
# 3. ls /usr/bin > usr_bin_new
# 4. diff usr_bin_new usr_bin_orig | awk '/^< (llvm-).*-16$/ {gsub("-16",""); printf "%s ", $2} END {print ""}' > slaves_llvm
# 5  diff usr_bin_new usr_bin_orig | awk '/^< / && !/llvm-/ && /-16$/ {gsub("^< ",""); gsub("-16$",""); printf "%s ", $0} END {print ""}' > slaves_clang