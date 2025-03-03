{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,

  # dependencies
  django,
  persisting-theory,
  six,

  # tests
  djangorestframework,
  pytest-django,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "django-dynamic-preferences";
  version = "1.15.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "agateblue";
    repo = "django-dynamic-preferences";
    tag = version;
    hash = "sha256-S0PAlSrMOQ68mX548pZzARfau/lytXWC4S5uVO1rUmo=";
  };

  buildInputs = [ django ];

  propagatedBuildInputs = [
    six
    persisting-theory
  ];

  nativeCheckInputs = [
    djangorestframework
    pytestCheckHook
    pytest-django
  ];

  pythonImportsCheck = [ "dynamic_preferences" ];

  # Remove once https://github.com/agateblue/django-dynamic-preferences/issues/309 is fixed
  doCheck = pythonOlder "3.12";

  env.DJANGO_SETTINGS = "tests.settings";

  meta = with lib; {
    changelog = "https://github.com/agateblue/django-dynamic-preferences/blob/${version}/HISTORY.rst";
    homepage = "https://github.com/EliotBerriot/django-dynamic-preferences";
    description = "Dynamic global and instance settings for your django project";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mmai ];
  };
}
