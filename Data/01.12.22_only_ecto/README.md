Started on 01/12/2022

For section 2: how do ectosymbionts evolve if there is no endosymbiosis? Run with symbulation linked in the repo but with modification: in GrowOlder() in Symbiont.h the organism is set dead by:
dead = true;
rather than SetDead();
