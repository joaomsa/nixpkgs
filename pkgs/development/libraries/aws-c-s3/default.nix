{ lib, stdenv
, fetchFromGitHub
, aws-c-auth
, aws-c-cal
, aws-c-common
, aws-c-compression
, aws-c-http
, aws-c-io
, aws-checksums
, cmake
, nix
, s2n-tls
}:

stdenv.mkDerivation rec {
  pname = "aws-c-s3";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "awslabs";
    repo = "aws-c-s3";
    rev = "v${version}";
    sha256 = "sha256-PT6ivk6WsM27jaULJ5CBAojaO7rGxzs/cxv7aRf2nn8=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    aws-c-auth
    aws-c-cal
    aws-c-common
    aws-c-compression
    aws-c-http
    aws-c-io
    aws-checksums
    s2n-tls
  ];

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=ON"
  ];

  passthru.tests = {
    inherit nix;
  };

  meta = with lib; {
    description = "C99 library implementation for communicating with the S3 service";
    homepage = "https://github.com/awslabs/aws-c-s3";
    license = licenses.asl20;
    maintainers = with maintainers; [ r-burns ];
    mainProgram = "s3";
    platforms = platforms.unix;
  };
}
