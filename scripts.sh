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
