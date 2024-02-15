terraform {
  backend "http" {
    address         = "https://gitlab.it-git.ru/api/v4/projects/3/terraform/state/diplom.tfstate"
    lock_address    = "https://gitlab.it-git.ru/api/v4/projects/3/terraform/state/diplom.tfstate/lock"
    unlock_address  = "https://gitlab.it-git.ru/api/v4/projects/3/terraform/state/diplom.tfstate/lock"
    username        = "root2"
    password        = "glpat-P6gg2B_Hphf1e711_mYx"
    lock_method     = "POST"
    unlock_method   = "DELETE"
    retry_wait_min  = 5
  }
}
