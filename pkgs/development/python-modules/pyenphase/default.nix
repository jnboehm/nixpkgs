{ lib
, awesomeversion
, buildPythonPackage
, envoy-utils
, fetchFromGitHub
, httpx
, lxml
, orjson
, poetry-core
, pyjwt
, pytest-asyncio
, pytestCheckHook
, pythonOlder
, respx
, syrupy
, tenacity
}:

buildPythonPackage rec {
  pname = "pyenphase";
  version = "1.9.1";
  format = "pyproject";

  disabled = pythonOlder "3.11";

  src = fetchFromGitHub {
    owner = "pyenphase";
    repo = "pyenphase";
    rev = "refs/tags/v${version}";
    hash = "sha256-6ThUly9ITs2UMCCBFTyKSNnD5Y87GmBA+iaTjk/mJWw=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=pyenphase --cov-report=term-missing:skip-covered" ""
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    awesomeversion
    envoy-utils
    httpx
    lxml
    orjson
    pyjwt
    tenacity
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
    respx
    syrupy
  ];

  pythonImportsCheck = [
    "pyenphase"
  ];

  meta = with lib; {
    description = "Library to control enphase envoy";
    homepage = "https://github.com/pyenphase/pyenphase";
    changelog = "https://github.com/pyenphase/pyenphase/blob/${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
