function bigMessage {
  echo -e "
---------------------------------------------
$1
---------------------------------------------";
}

function promptForGCloud {
  printf "Have you already run \"gcloud auth application-default login\"? [Y/n] ";
  read runGC;
  if [[ $runGC = "n" || $runGC = "N" ]]; then
    bigMessage "Setting up gcloud auth.  This will open a browser."
    read -p "Press [Enter] key to start..."
    (set -x; gcloud beta container clusters get-credentials vendasta-central --region us-central1 --project repcore-prod);
  fi
}

function promptForVendasta {
  printf "Have you already run \"mscli auth login\"? [Y/n] ";
  read runVA;
  if [[ $runVA = "n" || $runVA = "N" ]]; then
    bigMessage "Setting up Vendasta auth.  This will open a browser."
    read -p "Press [Enter] key to start..."
    (set -x; mscli auth login);
  fi
}

function promptUserForConfigValues {
  printf "Which environment should this instance read from (e.g. vStore)? [D]emo/prod? ";
  read env
  if [[ $env = D* || $env = demo || $env = "" ]]; then
    env="demo";
  elif [[ $env = prod ]]; then
    env="prod";
  else
    echo -e "\033[33;7mInvalid selection \"$env\".  Falling back to \"demo\".\033[0m";
    env="demo";
  fi;

  promptForGCloud;
  promptForVendasta;
}
