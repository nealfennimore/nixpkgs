{ lib
, rustPlatform
, fetchFromGitHub
, autoconf
, automake
, clang
, libclang
, libtool
}:
rustPlatform.buildRustPackage rec {
  pname = "jnv";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "ynqa";
    repo = "jnv";
    rev = "v${version}";
    hash = "sha256-LN42UyXOStwgj/bbHl2MK1jTsDACTjDo+QaoZ9FzurA=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };
  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    autoconf
    automake
    clang
    libclang
    libtool
  ];

  env.LIBCLANG_PATH = "${lib.getLib libclang}/lib";

  meta = with lib; {
    description = "Interactive JSON filter using jq";
    mainProgram = "jnv";
    homepage = "https://github.com/ynqa/jnv";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ nealfennimore ];
    platforms = platforms.unix;
  };
}
