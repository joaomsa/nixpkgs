{ lib
, buildPythonPackage
, setuptools
, cachetools
, decorator
, fetchFromGitHub
, future
, nose
, pysmt
, pythonOlder
, pytestCheckHook
, six
, z3
}:

buildPythonPackage rec {
  pname = "claripy";
  version = "9.2.31";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "angr";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-hIzB6E1z3ufbHFoe2IfBTuF4uuJibaFTqDjTf5ubHDU=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    cachetools
    decorator
    future
    pysmt
    z3
  ];

  checkInputs = [
    nose
    pytestCheckHook
    six
  ];

  postPatch = ''
    # Use upstream z3 implementation
    substituteInPlace setup.cfg \
      --replace "z3-solver == 4.10.2.0" ""
  '';

  pythonImportsCheck = [
    "claripy"
  ];

  meta = with lib; {
    description = "Python abstraction layer for constraint solvers";
    homepage = "https://github.com/angr/claripy";
    license = with licenses; [ bsd2 ];
    maintainers = with maintainers; [ fab ];
  };
}
