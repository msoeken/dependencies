#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$build is undefined'
  exit 1
fi

package=llvm+clang
version="3.1"
source_llvm="llvm-$version.src.tar.gz"
source_clang="clang-$version.src.tar.gz"
build_dir=$build/$package-$version.build
source_dir=$build/llvm-${version}.src
url_llvm="http://llvm.org/releases/$version/$source_llvm"
url_clang="http://llvm.org/releases/$version/$source_clang"

download_unpack() {
  cd $build &&
  download_http $source_llvm $url_llvm &&
  download_http $source_clang $url_clang &&
  message "unpacking $package" &&
  tar -xf $source_llvm &&
  tar -xvf $source_clang &&
  mv clang-$version.src $source_dir/tools/clang &&

  mkdir -p $build_dir &&
  cd $build_dir &&
  message "finished unpacking $package"

}

pre_build() {
  true
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
  exit 1
  fi
  cd "$build_dir" &&
  $source_dir/configure --prefix=$target &&
  make &&
  make install
}

