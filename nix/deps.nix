{ nixpkgs ? <nixpkgs>}:

with import nixpkgs {};

rec {
  immer = stdenv.mkDerivation rec {
    name = "immer-${version}";
    version = "git-${commit}";
    commit = "e5d79ed80ec74d511cc4f52fb68feeac66507f2c";
    src = fetchFromGitHub {
      owner = "arximboldi";
      repo = "immer";
      rev = commit;
      sha256 = "1h6m3hc26g15dhka6di6lphrl7wrgrxzn3nq0rfwg3iw10ifkw9f";
    };
    nativeBuildInputs = [ cmake ];
    buildInputs = [ boost ];
    meta = with lib; {
      homepage = "http://sinusoid.es/immer";
      description = "Immutable data structures for C++";
      license = licenses.lgpl3;
    };
  };

  scelta = stdenv.mkDerivation rec {
    name = "scelta-${version}";
    version = "git-${commit}";
    commit = "bd121843e227435f8f55c4aaf7e2de536f05b583";
    src = fetchFromGitHub {
      owner = "SuperV1234";
      repo = "scelta";
      rev = commit;
      sha256 = "0vcc2zh7mn517c8z2p32cg2apixzmx7wwmklzrcdxfk583cxim8c";
    };
    dontBuild = true;
    installPhase = "mkdir -vp $out/include; cp -vr $src/include/* $out/include/";
    meta = with lib; {
      description = "Syntax sugar for variants";
      license = licenses.mit;
    };
  };

  utfcpp = stdenv.mkDerivation rec {
    name = "utfcpp-${version}";
    version = "git-${commit}";
    commit = "67036a031d131b5a929a525677e4356850fa4e37";
    src = fetchFromGitHub {
      owner = "nemtrif";
      repo = "utfcpp";
      rev = commit;
      sha256 = "12h4ysmlzqgx19v251bkx839v5fav4qg3hry9a45d1xkl0l1sqsm";
    };
    dontBuild = true;
    installPhase = "mkdir -vp $out/include; cp -vr $src/source/* $out/include/";
    meta = with lib; {
      description = "UTF-8 with C++ in a Portable Way";
      license = licenses.mit;
    };
  };

  cereal = stdenv.mkDerivation rec {
    name = "cereal-${version}";
    version = "git-arximboldi-${commit}";
    commit = "2fe15c57f813db1b14c9b5e3e2389f7c5d1c5aff";
    src = fetchFromGitHub {
      owner = "flyqaq";
      repo = "cereal";
      rev = commit;
      sha256 = "119sldlzkrpnbb0kg052b851kifc7hwnc5vik1fdklramx5gzy97";
    };
    nativeBuildInputs = [ cmake ];
    cmakeFlags="-DJUST_INSTALL_CEREAL=true";
    meta = with lib; {
      homepage = "http://uscilab.github.io/cereal";
      description = "A C++11 library for serialization";
      license = licenses.bsd3;
    };
  };

  lager = stdenv.mkDerivation rec {
    name = "lager";
    version = "git-${commit}";
    commit = "0f311b5a99fd24fb559ff2d615facdfb44523ee1";
    src = fetchFromGitHub {
      owner = "flyqaq";
      repo = "lager";
      rev = commit;
      sha256 = "1khjfph0kw17jla8d7lfz5syplssv15f6ijz33m62v3l3a53qnhn";
    };
    buildInputs = [
      ncurses
    ];
    nativeBuildInputs = [
      cmake
      gcc7
      sass
    ];
    propagatedBuildInputs = [
      boost
      immer
      zug
      cereal
    ];
    cmakeFlags="-Dlager_BUILD_TESTS=OFF -Dlager_BUILD_FAILURE_TESTS=OFF";
    meta = with lib; {
      homepage    = "https://github.com/arximboldi/lager";
      description = "library for functional interactive c++ programs";
      license     = licenses.lgpl3Plus;
    };
  };

  zug = stdenv.mkDerivation rec {
    name = "zug";
    version = "git-${commit}";
    commit = "deb266f4c7c35d325de7eb3d033f06e0809495f2";
    src = fetchFromGitHub {
      owner = "arximboldi";
      repo = "zug";
      rev = commit;
      sha256 = "0af6xv22y35zyky07h52bwb2dksqz138sr59kxbnnj7vwsiq5j5s";
    };
    nativeBuildInputs = [ cmake ];
    meta = with lib; {
      homepage = "http://sinusoid.es/zug";
      description = "Transducers for C++";
      license = licenses.boost;
    };
  };
}
