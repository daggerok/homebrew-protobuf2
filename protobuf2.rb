require 'formula'

class Protobuf2 < Formula
  version "2.5.0"
  name "Google Protobuf v#{version}"
  desc "Google Protocol Buffers v#{version}"
  homepage "https://github.com/daggerok/protobuf2"
  sha256 "c55aa3dc538e6fd5eaf732f4eb6b98bdcb7cedb5b91d3b5bdcf29c98c293f58e"
  license :mit
  url "https://github.com/protocolbuffers/protobuf/releases/download/v#{version}/protobuf-#{version}.tar.gz"

  option :universal

  def install
    # Don't build in debug mode. See:
    # https://github.com/Homebrew/homebrew/issues/9279
    # https://github.com/protocolbuffers/protobuf/blob/5c24564811c08772d090305be36fae82d8f12bbe/configure.ac#L61
    ENV.prepend "CXXFLAGS", "-DNDEBUG"
    ENV.cxx11

    system "./configure", "CC=clang", "CXX=clang++", "CXXFLAGS='-std=c++11 -stdlib=libc++ -O3 -g'",
                          "LDFLAGS='-stdlib=libc++'", "LIBS='-lc++ -lc++abi'"
    # system "./configure", "--disable-debug", "--disable-dependency-tracking",
    #                       "--prefix=#{prefix}", "--with-zlib"
    system "make"
    system "make", "check"
    system "make", "install"

    # ENV.append_to_cflags "-I#{include}"
    # ENV.append_to_cflags "-L#{lib}"
  end

  # test do
  #   testdata = <<~EOS
  #     syntax = "proto3";
  #     package test;
  #     message TestCase {
  #       string name = 4;
  #     }
  #     message Test {
  #       repeated TestCase case = 1;
  #     }
  #   EOS
  #   (testpath/"test.proto").write testdata
  # end
end
