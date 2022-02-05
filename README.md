# Covid-19 ERC721 Simulator

This project takes a spin on the CryptoZombies project where hosts can be infected by Covid-19.

Two hosts can interact with one another. When a host has the covid infection, there is a possibility for the host to spread. Hosts can become vaccinated and wear masks to reduce their chance of infection. The effectiveness of a vaccination is determined by the mRNA of the vaccination and the RNA of the covid variant.

The user can perform the following actions:
1. A host can be created.
2. A host can interact with another host.
3. A host can put on a mask.
4. A host can remove a mask.
5. A host can get vaccinated.

The following interactions can occur:
1. If neither host has covid, no infections occur.
2. 1 host has covid, it can infect another. If newly infected host is vaccinated, the vaccination mRNA will mutate to become more effective against the specific covid strain.
3. If both hosts have covid, a new variant is formed. 
